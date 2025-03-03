import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class BooksPage extends StatelessWidget {
  static const List<Map<String, String>> books = const [
    const {'title': 'D&D 5E - Livro do Jogador (Fundo Colorido)', 'url': 'https://github.com/bibliotecaelfica/bibliotecaelfica.github.io/files/3611502/D.D.5E.-.Livro.do.Jogador.Fundo.Colorido.pdf'},
    const {'title': 'Gaia - O Preludio - Manual de Demonstração 2.0', 'url': 'https://drive.google.com/uc?export=download&id=1lAAeTm7xIj_P2LlDBIYBkxq24GssJvZD'},
  ];

  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Livros de RPG')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book['title']!),
            trailing: const Icon(Icons.picture_as_pdf),
            onTap: () => _openPdf(context, book['url']!),
          );
        },
      ),
    );
  }

  void _openPdf(BuildContext context, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfViewerScreen(pdfUrl: url),
      ),
    );
  }
}

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;

  const PdfViewerScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? localPath;
  bool _isLoading = true;
  int _totalPages = 0;
  int _currentPage = 0;
  PDFViewController? _pdfViewController;
  final TextEditingController _pageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _downloadAndOpenPdf();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _downloadAndOpenPdf() async {
    try {
      final response = await http.get(Uri.parse(widget.pdfUrl));
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/temp.pdf');
      await file.writeAsBytes(response.bodyBytes);
      
      setState(() {
        localPath = file.path;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar PDF: $e')),
      );
      Navigator.pop(context);
    }
  }

  void _goToPage(String input) {
    if (input.isEmpty) return;

    final int? page = int.tryParse(input);
    if (page == null || page < 1 || page > _totalPages) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Página inválida! Digite entre 1 e $_totalPages'),
          duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    _pdfViewController?.setPage(page - 1);
    _pageController.clear();
  }

  void _showGoToPageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ir para página'),
        content: TextField(
          controller: _pageController,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'Digite o número da página (1-$_totalPages)',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _goToPage(_pageController.text);
              Navigator.pop(context);
            },
            child: const Text('Ir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizador de PDF'),
        actions: [
          if (!_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('$_currentPage/$_totalPages'),
            ),
          if (!_isLoading)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _showGoToPageDialog,
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: localPath,
              autoSpacing: true,
              enableSwipe: true,
              pageSnap: true,
              swipeHorizontal: true,
              onError: (error) => print(error),
              onRender: (_pages) {
                setState(() {
                  _totalPages = _pages!;
                });
              },
              onViewCreated: (PDFViewController controller) {
                _pdfViewController = controller;
              },
              onPageChanged: (page, total) {
                setState(() {
                  _currentPage = page! + 1;
                });
              },
            ),
    );
  }
}