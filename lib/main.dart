import 'package:flutter/material.dart';
import 'models/character_sheet.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ficha de RPG',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

/// Tela principal 
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() { _currentPage = index; });
        },
        children: const [
          CharacterSheetListScreen(), // Página de fichas
          BooksPage(), // Página de livros de RPG
          AICharacterSheetScreen(), // Página de criação com IA
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Fichas'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Livros'),
          BottomNavigationBarItem(icon: Icon(Icons.smart_toy), label: 'IA'),
        ],
      ),
    );
  }
}

/// Página de livros de RPG (placeholder)
class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Livros de RPG')),
      body: const Center(child: Text('Conteúdo dos livros de RPG aqui')),
    );
  }
}

/// Página de criação com IA (placeholder)
class AICharacterSheetScreen extends StatelessWidget {
  const AICharacterSheetScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criação com IA')),
      body: const Center(child: Text('Interface de criação de fichas com IA aqui')),
    );
  }
}


/// Tela que exibe a lista das fichas salvas (agora com suporte para D&D e Gaia)
class CharacterSheetListScreen extends StatefulWidget {
  const CharacterSheetListScreen({super.key});
  @override
  _CharacterSheetListScreenState createState() =>
      _CharacterSheetListScreenState();
}

class _CharacterSheetListScreenState extends State<CharacterSheetListScreen> {
  List<CharacterSheetUniveresal> characterSheets = [];

  @override
  void initState() {
    super.initState();
    _loadCharacterSheets();
  }

  Future<void> _loadCharacterSheets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('characterSheets');
    if (data != null) {
      try {
        final List<dynamic> decoded = json.decode(data);
        setState(() {
          characterSheets = decoded.map((item) {
            final map = item as Map<String, dynamic>;
            if (map['type'] == 'dnd') {
              return CharacterSheetDeD.fromMap(map);
            } else if (map['type'] == 'gaia') {
              return CharacterSheetGaia.fromMap(map);
            } else {
              return CharacterSheetDeD.fromMap(map);
            }
          }).toList();
        });
      } catch (e) {
        print("Erro ao decodificar as fichas: $e");
      }
    }
  }

  Future<void> _saveCharacterSheets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> maps =
        characterSheets.map((cs) => cs.toMap()).toList();

    await prefs.setString('characterSheets', json.encode(maps));
  }

  void _navigateToNewSheet() async {
    // Exibe um diálogo para escolher entre D&D e Gaia
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolha o tipo de ficha'),
        content: const Text('Selecione o sistema para a ficha:'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'dnd'),
            child: const Text('D&D'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'gaia'),
            child: const Text('Gaia'),
          ),
        ],
      ),
    );
    if (choice == 'dnd') {
      final newSheet = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewCharacterSheetScreen()),
      );
      if (newSheet != null && newSheet is CharacterSheetDeD) {
        setState(() { characterSheets.add(newSheet); });
        _saveCharacterSheets();
      }
    } else if (choice == 'gaia') {
      final newSheet = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewCharacterSheetGaiaScreen()),
      );
      if (newSheet != null && newSheet is CharacterSheetGaia) {
        setState(() { characterSheets.add(newSheet); });
        _saveCharacterSheets();
      }
    }
  }

  void _navigateToEditSheet(int index) async {
    final sheetToEdit = characterSheets[index];
    if (sheetToEdit is CharacterSheetDeD) {
      final updatedSheet = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewCharacterSheetScreen(sheet: sheetToEdit),
        ),
      );
      if (updatedSheet != null && updatedSheet is CharacterSheetDeD) {
        setState(() { characterSheets[index] = updatedSheet; });
        _saveCharacterSheets();
      }
    } else if (sheetToEdit is CharacterSheetGaia) {
      final updatedSheet = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewCharacterSheetGaiaScreen(sheet: sheetToEdit),
        ),
      );
      if (updatedSheet != null && updatedSheet is CharacterSheetGaia) {
        setState(() { characterSheets[index] = updatedSheet; });
        _saveCharacterSheets();
      }
    }
  }

  void _navigateToSheetDetails(CharacterSheetUniveresal sheet) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterSheetDetailsScreen(sheet: sheet),
      ),
    );
  }

  void _deleteSheet(int index) {
    setState(() { characterSheets.removeAt(index); });
    _saveCharacterSheets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Fichas de RPG')),
      body: characterSheets.isEmpty
          ? const Center(child: Text("Nenhuma ficha encontrada."))
          : ListView.builder(
              itemCount: characterSheets.length,
              itemBuilder: (context, index) {
                final cs = characterSheets[index];
                String subtitle = "Nível ${cs.nivel}";
                if (cs is CharacterSheetDeD) {
                  subtitle = "${cs.classe} - Nível ${cs.nivel}";
                } else if (cs is CharacterSheetGaia) {
                  subtitle = "Legado: ${cs.legado} - Nível ${cs.nivel}";
                }
                return Card(
                  child: ListTile(
                    title: Text(cs.nome),
                    subtitle: Text(subtitle),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility, color: Colors.blue),
                          onPressed: () => _navigateToSheetDetails(cs),
                          tooltip: "Visualizar",
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _navigateToEditSheet(index),
                          tooltip: "Editar",
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteSheet(index),
                          tooltip: "Excluir",
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToNewSheet,
        tooltip: "Nova Ficha",
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Tela de detalhes da ficha (diferencia D&D e Gaia)
class CharacterSheetDetailsScreen extends StatelessWidget {
  final CharacterSheetUniveresal sheet;
  const CharacterSheetDetailsScreen({Key? key, required this.sheet}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<DataRow> rows = [];
    rows.add(DataRow(cells: [DataCell(Text("Nome")), DataCell(Text(sheet.nome))]));
    rows.add(DataRow(cells: [DataCell(Text("Nível")), DataCell(Text(sheet.nivel.toString()))]));
    rows.add(DataRow(cells: [DataCell(Text("Anotações")), DataCell(Text(sheet.anotacoes))]));
    
    if (sheet is CharacterSheetDeD) {
      final dnd = sheet as CharacterSheetDeD;
      rows.insert(1, DataRow(cells: [DataCell(Text("Classe")), DataCell(Text(dnd.classe))]));
      rows.insert(2, DataRow(cells: [DataCell(Text("Raça")), DataCell(Text(dnd.raca))]));
      rows.insert(3, DataRow(cells: [DataCell(Text("Força")), DataCell(Text(dnd.forca.toString()))]));
      rows.insert(4, DataRow(cells: [DataCell(Text("Destreza")), DataCell(Text(dnd.destreza.toString()))]));
      rows.insert(5, DataRow(cells: [DataCell(Text("Constituição")), DataCell(Text(dnd.constituicao.toString()))]));
      rows.insert(6, DataRow(cells: [DataCell(Text("Inteligência")), DataCell(Text(dnd.inteligencia.toString()))]));
      rows.insert(7, DataRow(cells: [DataCell(Text("Sabedoria")), DataCell(Text(dnd.sabedoria.toString()))]));
      rows.insert(8, DataRow(cells: [DataCell(Text("Carisma")), DataCell(Text(dnd.carisma.toString()))]));
    } else if (sheet is CharacterSheetGaia) {
      final gaia = sheet as CharacterSheetGaia;
      rows.insert(1, DataRow(cells: [DataCell(Text("Legado")), DataCell(Text(gaia.legado))]));
      rows.insert(2, DataRow(cells: [DataCell(Text("Vida")), DataCell(Text(gaia.vida.toString()))]));
      rows.insert(3, DataRow(cells: [DataCell(Text("PE")), DataCell(Text(gaia.pe.toString()))]));
      rows.insert(4, DataRow(cells: [DataCell(Text("Movimentação")), DataCell(Text(gaia.movimentacao.toString()))]));
      rows.insert(5, DataRow(cells: [DataCell(Text("Bloqueio")), DataCell(Text(gaia.bloqueio.toString()))]));
      rows.insert(6, DataRow(cells: [DataCell(Text("Precisão")), DataCell(Text(gaia.precisao.toString()))]));
      rows.insert(7, DataRow(cells: [DataCell(Text("Brutalidade")), DataCell(Text(gaia.brutalidade.toString()))]));
      rows.insert(8, DataRow(cells: [DataCell(Text("Destreza")), DataCell(Text(gaia.destreza.toString()))]));
      rows.insert(9, DataRow(cells: [DataCell(Text("Agilidade")), DataCell(Text(gaia.agilidade.toString()))]));
      rows.insert(10, DataRow(cells: [DataCell(Text("Canalizção")), DataCell(Text(gaia.canalizacao.toString()))]));
      rows.insert(11, DataRow(cells: [DataCell(Text("Arcanismo")), DataCell(Text(gaia.arcanismo.toString()))]));
      rows.insert(12, DataRow(cells: [DataCell(Text("Espirito")), DataCell(Text(gaia.espirito.toString()))]));
      rows.insert(13, DataRow(cells: [DataCell(Text("Vigor")), DataCell(Text(gaia.vigor.toString()))]));
      rows.insert(14, DataRow(cells: [DataCell(Text("Carisma")), DataCell(Text(gaia.carisma.toString()))]));
      rows.insert(15, DataRow(cells: [DataCell(Text("Medicina")), DataCell(Text(gaia.medicina.toString()))]));
      rows.insert(16, DataRow(cells: [DataCell(Text("Con. Misticos")), DataCell(Text(gaia.conhecimentosMisticos.toString()))]));
      rows.insert(17, DataRow(cells: [DataCell(Text("Percepção")), DataCell(Text(gaia.percepcao.toString()))]));
      rows.insert(18, DataRow(cells: [DataCell(Text("Exploração")), DataCell(Text(gaia.exploracao.toString()))]));
      rows.insert(19, DataRow(cells: [DataCell(Text("Performance")), DataCell(Text(gaia.performance.toString()))]));
      rows.insert(20, DataRow(cells: [DataCell(Text("Furtividade")), DataCell(Text(gaia.furtividade.toString()))]));
      rows.insert(21, DataRow(cells: [DataCell(Text("Religião")), DataCell(Text(gaia.religiao.toString()))]));
      rows.insert(22, DataRow(cells: [DataCell(Text("História")), DataCell(Text(gaia.historia.toString()))]));
      rows.insert(23, DataRow(cells: [DataCell(Text("Sobrevivência")), DataCell(Text(gaia.sobrevivencia.toString()))]));
      rows.insert(24, DataRow(cells: [DataCell(Text("Intimidação")), DataCell(Text(gaia.intimidacao.toString()))]));
      rows.insert(25, DataRow(cells: [DataCell(Text("Tecnologia")), DataCell(Text(gaia.tecnologia.toString()))]));
      rows.insert(26, DataRow(cells: [DataCell(Text("Intuição")), DataCell(Text(gaia.intuicao.toString()))]));
      rows.insert(27, DataRow(cells: [DataCell(Text("Vontade")), DataCell(Text(gaia.vontade.toString()))]));
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes da Ficha")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Atributo", style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text("Valor", style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: rows,
        ),
      ),
    );
  }
}

/// Tela para criação/edição de ficha D&D (já existente)
class NewCharacterSheetScreen extends StatefulWidget {
  final CharacterSheetDeD? sheet;
  const NewCharacterSheetScreen({super.key, this.sheet});
  @override
  _NewCharacterSheetScreenState createState() =>
      _NewCharacterSheetScreenState();
}

class _NewCharacterSheetScreenState extends State<NewCharacterSheetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _classeController = TextEditingController();
  final _racaController = TextEditingController();
  final _nivelController = TextEditingController();
  final _forcaController = TextEditingController();
  final _destrezaController = TextEditingController();
  final _constituicaoController = TextEditingController();
  final _inteligenciaController = TextEditingController();
  final _sabedoriaController = TextEditingController();
  final _carismaController = TextEditingController();
  final _anotacoesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.sheet != null) {
      _nomeController.text = widget.sheet!.nome;
      _classeController.text = widget.sheet!.classe;
      _racaController.text = widget.sheet!.raca;
      _nivelController.text = widget.sheet!.nivel.toString();
      _forcaController.text = widget.sheet!.forca.toString();
      _destrezaController.text = widget.sheet!.destreza.toString();
      _constituicaoController.text = widget.sheet!.constituicao.toString();
      _inteligenciaController.text = widget.sheet!.inteligencia.toString();
      _sabedoriaController.text = widget.sheet!.sabedoria.toString();
      _carismaController.text = widget.sheet!.carisma.toString();
      _anotacoesController.text = widget.sheet!.anotacoes;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _classeController.dispose();
    _racaController.dispose();
    _nivelController.dispose();
    _forcaController.dispose();
    _destrezaController.dispose();
    _constituicaoController.dispose();
    _inteligenciaController.dispose();
    _sabedoriaController.dispose();
    _carismaController.dispose();
    _anotacoesController.dispose();
    super.dispose();
  }

  void _saveCharacterSheet() {
    if (_formKey.currentState?.validate() ?? false) {
      final newSheet = CharacterSheetDeD(
        nome: _nomeController.text,
        classe: _classeController.text,
        raca: _racaController.text,
        nivel: int.tryParse(_nivelController.text) ?? 1,
        forca: int.tryParse(_forcaController.text) ?? 10,
        destreza: int.tryParse(_destrezaController.text) ?? 10,
        constituicao: int.tryParse(_constituicaoController.text) ?? 10,
        inteligencia: int.tryParse(_inteligenciaController.text) ?? 10,
        sabedoria: int.tryParse(_sabedoriaController.text) ?? 10,
        carisma: int.tryParse(_carismaController.text) ?? 10,
        anotacoes: _anotacoesController.text,
      );
      Navigator.pop(context, newSheet);
    }
  }

  Widget _buildNumberField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Informe o $label' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.sheet != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Ficha de RPG' : 'Nova Ficha de RPG'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _classeController,
                decoration: const InputDecoration(labelText: 'Classe'),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Informe a classe' : null,
              ),
              TextFormField(
                controller: _racaController,
                decoration: const InputDecoration(labelText: 'Raça'),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Informe a raça' : null,
              ),
              _buildNumberField(_nivelController, 'Nível'),
              _buildNumberField(_forcaController, 'Força'),
              _buildNumberField(_destrezaController, 'Destreza'),
              _buildNumberField(_constituicaoController, 'Constituição'),
              _buildNumberField(_inteligenciaController, 'Inteligência'),
              _buildNumberField(_sabedoriaController, 'Sabedoria'),
              _buildNumberField(_carismaController, 'Carisma'),
              TextFormField(
                maxLines: 3,
                controller: _anotacoesController,
                decoration: const InputDecoration(labelText: 'Anotações'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveCharacterSheet,
                child: Text(isEditing ? 'Atualizar Ficha' : 'Salvar Ficha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tela para criação/edição de ficha Gaia
class NewCharacterSheetGaiaScreen extends StatefulWidget {
  
  final CharacterSheetGaia? sheet;
  const NewCharacterSheetGaiaScreen({Key? key, this.sheet}) : super(key: key);
  @override
  _NewCharacterSheetGaiaScreenState createState() =>
      _NewCharacterSheetGaiaScreenState();
}

class _NewCharacterSheetGaiaScreenState extends State<NewCharacterSheetGaiaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _nivelController = TextEditingController();
  String? _selectedLegado;
  final _vidaController = TextEditingController();
  final _peController = TextEditingController();
  final _movimentacaoController = TextEditingController();
  final _bloqueioController = TextEditingController();
  final _precisaoController = TextEditingController();
  final _brutalidadeController = TextEditingController();
  final _destrezaController = TextEditingController();
  final _agilidadeController = TextEditingController();
  final _canalizacaoController = TextEditingController();
  final _arcanismoController = TextEditingController();
  final _espiritoController = TextEditingController();
  final _vigorController = TextEditingController();
  final _carismaController = TextEditingController();
  final _medicinaController = TextEditingController();
  final _conhecimentosMisticosController = TextEditingController();
  final _percepcaoController = TextEditingController();
  final _exploracaoController = TextEditingController();
  final _performanceController = TextEditingController();
  final _furtividadeController = TextEditingController();
  final _religiaoController = TextEditingController();
  final _historiaController = TextEditingController();
  final _sobrevivenciaController = TextEditingController();
  final _intimidacaoController = TextEditingController();
  final _tecnologiaController = TextEditingController();
  final _intuicaoController = TextEditingController();
  final _vontadeController = TextEditingController();
  final _anotacoesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.sheet != null) {
      _nomeController.text = widget.sheet!.nome;
      _nivelController.text = widget.sheet!.nivel.toString();
      _selectedLegado = widget.sheet!.legado;
      _vidaController.text = widget.sheet!.vida.toString();
      _peController.text = widget.sheet!.pe.toString();
      _movimentacaoController.text =
          widget.sheet!.movimentacao.toString();
      _bloqueioController.text = widget.sheet!.bloqueio.toString();
      _precisaoController.text = widget.sheet!.precisao.toString();
      _brutalidadeController.text = widget.sheet!.brutalidade.toString();
      _destrezaController.text = widget.sheet!.destreza.toString();
      _agilidadeController.text = widget.sheet!.agilidade.toString();
      _canalizacaoController.text = widget.sheet!.canalizacao.toString();
      _arcanismoController.text = widget.sheet!.arcanismo.toString();
      _espiritoController.text = widget.sheet!.espirito.toString();
      _vigorController.text = widget.sheet!.vigor.toString();
      _carismaController.text = widget.sheet!.carisma.toString();
      _medicinaController.text = widget.sheet!.medicina.toString();
      _conhecimentosMisticosController.text =
          widget.sheet!.conhecimentosMisticos.toString();
      _percepcaoController.text = widget.sheet!.percepcao.toString();
      _exploracaoController.text = widget.sheet!.exploracao.toString();
      _performanceController.text = widget.sheet!.performance.toString();
      _furtividadeController.text = widget.sheet!.furtividade.toString();
      _religiaoController.text = widget.sheet!.religiao.toString();
      _historiaController.text = widget.sheet!.historia.toString();
      _sobrevivenciaController.text = widget.sheet!.sobrevivencia.toString();
      _intimidacaoController.text = widget.sheet!.intimidacao.toString();
      _tecnologiaController.text = widget.sheet!.tecnologia.toString();
      _intuicaoController.text = widget.sheet!.intuicao.toString();
      _vontadeController.text = widget.sheet!.vontade.toString();
      _anotacoesController.text = widget.sheet!.anotacoes;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _nivelController.dispose();
    
    _vidaController.dispose();
    _peController.dispose();
    _movimentacaoController.dispose();
    _bloqueioController.dispose();
    _precisaoController.dispose();
    _brutalidadeController.dispose();
    _destrezaController.dispose();
    _agilidadeController.dispose();
    _canalizacaoController.dispose();
    _arcanismoController.dispose();
    _espiritoController.dispose();
    _vigorController.dispose();
    _carismaController.dispose();
    _medicinaController.dispose();
    _conhecimentosMisticosController.dispose();
    _percepcaoController.dispose();
    _exploracaoController.dispose();
    _performanceController.dispose();
    _furtividadeController.dispose();
    _religiaoController.dispose();
    _historiaController.dispose();
    _sobrevivenciaController.dispose();
    _intimidacaoController.dispose();
    _tecnologiaController.dispose();
    _intuicaoController.dispose();
    _vontadeController.dispose();
    _anotacoesController.dispose();
    super.dispose();
  }

  void _saveCharacterSheet() {
  if (_formKey.currentState?.validate() ?? false) {
    final newSheet = CharacterSheetGaia(
      nome: _nomeController.text,
      nivel: int.tryParse(_nivelController.text) ?? 1,
      legado: _selectedLegado??'',
      vida: int.tryParse(_vidaController.text) ?? 1,
      pe: int.tryParse(_peController.text) ?? 1,
      movimentacao: int.tryParse(_movimentacaoController.text) ?? 1,
      bloqueio: int.tryParse(_bloqueioController.text) ?? 1,
      precisao: int.tryParse(_precisaoController.text) ?? 1,
      brutalidade: int.tryParse(_brutalidadeController.text) ?? 1,
      destreza: int.tryParse(_destrezaController.text) ?? 1,
      agilidade: int.tryParse(_agilidadeController.text) ?? 1, 
      canalizacao: int.tryParse(_canalizacaoController.text) ?? 1,
      arcanismo: int.tryParse(_arcanismoController.text) ?? 1,
      espirito: int.tryParse(_espiritoController.text) ?? 1,
      vigor: int.tryParse(_vigorController.text) ?? 1,
      carisma: int.tryParse(_carismaController.text) ?? 1,
      medicina: int.tryParse(_medicinaController.text) ?? 1,
      conhecimentosMisticos: int.tryParse(_conhecimentosMisticosController.text) ?? 1,
      percepcao: int.tryParse(_percepcaoController.text) ?? 1,
      exploracao: int.tryParse(_exploracaoController.text) ?? 1,
      performance: int.tryParse(_performanceController.text) ?? 1,
      furtividade: int.tryParse(_furtividadeController.text) ?? 1,
      religiao: int.tryParse(_religiaoController.text) ?? 1,
      historia: int.tryParse(_historiaController.text) ?? 1,
      sobrevivencia: int.tryParse(_sobrevivenciaController.text) ?? 1,
      intimidacao: int.tryParse(_intimidacaoController.text) ?? 1,
      tecnologia: int.tryParse(_tecnologiaController.text) ?? 1,
      intuicao: int.tryParse(_intuicaoController.text) ?? 1,
      vontade: int.tryParse(_vontadeController.text) ?? 1,
      anotacoes: _anotacoesController.text,
    );
    Navigator.pop(context, newSheet);
  }
}


  Widget _buildNumberField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Informe o $label' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.sheet != null;
    return Scaffold(
      appBar: AppBar(
        title:
            Text(isEditing ? 'Editar Ficha Gaia' : 'Nova Ficha Gaia'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campos de texto para os atributos da ficha Gaia
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Informe o nome'
                              : null,
                    ),
                  ),
                  const SizedBox(width: 16.0,),
                  Expanded(child: _buildNumberField(_nivelController, 'Nível'),)
                ],
              ),
              
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedLegado,
                      decoration: const InputDecoration(
                        labelText: 'Legado',
                        border: OutlineInputBorder(),
                      ),
                      
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 16,
                      ),
                      items: Legados().legados
                          .map((legado) => DropdownMenuItem<String>(
                                value: legado,
                                child: Text(legado),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedLegado = value;
                        });
                      },
                      validator: (value) =>
                          value == null ? 'Selecione um legado' : null,
                    ),
                  ),
                  const SizedBox(width: 16.0,),
                  Expanded(child:_buildNumberField(_bloqueioController, 'Bloqueio'),),
                ],
              ),
              
              Row(
                children: [
                  Expanded(child: _buildNumberField(_vidaController, 'Vida'),), 
                  const SizedBox(width: 16.0,),
                  Expanded(child: _buildNumberField(_peController, 'PE'),), 
                  const SizedBox(width: 16.0,),
                  Expanded(child: _buildNumberField(_movimentacaoController, 'Movimentação'),), 
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'PARAMETROS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: 
                    Column(
                      children: [
                        _buildNumberField(_precisaoController, 'Precisão'),
                        _buildNumberField(_brutalidadeController, 'Brutalidade'),
                        _buildNumberField(_destrezaController, 'Destreza'),
                        _buildNumberField(_agilidadeController, 'Agilidade'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(width: 16.0,),
                  Expanded(child: 
                    Column(
                    children: [
                      _buildNumberField(_canalizacaoController, 'Canalização'),
                      _buildNumberField(_arcanismoController, 'Arcanismo'),
                      _buildNumberField(_espiritoController, 'Espírito'),
                      _buildNumberField(_vigorController, 'Vigor'),
                    ],
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'CONHECIMENTOS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: 
                    Column(
                      children: [
                        _buildNumberField(_carismaController, 'Carisma'),
                        _buildNumberField(_conhecimentosMisticosController,'Con. Místicos'),
                        _buildNumberField(_exploracaoController, 'Exploração'),
                        _buildNumberField(_furtividadeController, 'Furtividade'),
                        _buildNumberField(_historiaController, 'História'),
                        _buildNumberField(_intimidacaoController, 'Intimidação'),
                        _buildNumberField(_intuicaoController, 'Intuição'),
                      ],
                    )
                  ),
                  const SizedBox(width: 16.0,),
                  Expanded(child: 
                    Column(
                      children: [
                        _buildNumberField(_medicinaController, 'Medicina'),
                        _buildNumberField(_percepcaoController, 'Percepção'),
                        _buildNumberField(_performanceController, 'Performance'),
                        _buildNumberField(_religiaoController, 'Religião'),
                        _buildNumberField(_sobrevivenciaController, 'Sobrevivência'),
                        _buildNumberField(_tecnologiaController, 'Tecnologia'),
                        _buildNumberField(_vontadeController, 'Vontade'),
                      ],
                    )
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'ANOTAÇÕES',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              TextFormField(
                controller: _anotacoesController,
                decoration:
                    const InputDecoration(labelText: 'Anotações'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final newSheet = CharacterSheetGaia(
                      nome: _nomeController.text,
                      legado: _selectedLegado??'',
                      nivel: int.tryParse(_nivelController.text) ?? 1,
                      vida: int.tryParse(_vidaController.text) ?? 1,
                      pe: int.tryParse(_peController.text) ?? 1,
                      movimentacao:
                          int.tryParse(_movimentacaoController.text) ?? 1,
                      bloqueio:
                          int.tryParse(_bloqueioController.text) ?? 1,
                      precisao:
                          int.tryParse(_precisaoController.text) ?? 1,
                      brutalidade:
                          int.tryParse(_brutalidadeController.text) ?? 1,
                      destreza:
                          int.tryParse(_destrezaController.text) ?? 1,
                      agilidade:
                          int.tryParse(_agilidadeController.text) ?? 1,
                      canalizacao:
                          int.tryParse(_canalizacaoController.text) ?? 1,
                      arcanismo:
                          int.tryParse(_arcanismoController.text) ?? 1,
                      espirito:
                          int.tryParse(_espiritoController.text) ?? 1,
                      vigor:
                          int.tryParse(_vigorController.text) ?? 1,
                      carisma:
                          int.tryParse(_carismaController.text) ?? 1,
                      medicina:
                          int.tryParse(_medicinaController.text) ?? 1,
                      conhecimentosMisticos:
                          int.tryParse(_conhecimentosMisticosController.text) ??
                              1,
                      percepcao:
                          int.tryParse(_percepcaoController.text) ?? 1,
                      exploracao:
                          int.tryParse(_exploracaoController.text) ?? 1,
                      performance:
                          int.tryParse(_performanceController.text) ?? 1,
                      furtividade:
                          int.tryParse(_furtividadeController.text) ?? 1,
                      religiao:
                          int.tryParse(_religiaoController.text) ?? 1,
                      historia:
                          int.tryParse(_historiaController.text) ?? 1,
                      sobrevivencia:
                          int.tryParse(_sobrevivenciaController.text) ?? 1,
                      intimidacao:
                          int.tryParse(_intimidacaoController.text) ?? 1,
                      tecnologia:
                          int.tryParse(_tecnologiaController.text) ?? 1,
                      intuicao:
                          int.tryParse(_intuicaoController.text) ?? 1,
                      vontade:
                          int.tryParse(_vontadeController.text) ?? 1,
                      anotacoes: _anotacoesController.text,
                    );
                    Navigator.pop(context, newSheet);
                  }
                },
                child: Text(isEditing ? 'Atualizar Ficha' : 'Salvar Ficha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
