import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ficha de RPG - D&D',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CharacterSheetListScreen(),
    );
  }
}

//Modelo de ficha de personagem

abstract class CharacterSheetUniveresal {
  final String nome;
  final String anotacoes;
  // final String classe;
  // final String raca;
  // final int nivel;
  // final int forca;
  // final int destreza;
  // final int constituicao;
  // final int inteligencia;
  // final int sabedoria;
  // final int carisma;

  CharacterSheetUniveresal({
    required this.nome,
    required this.anotacoes,
    // required this.classe,
    // required this.raca,
    // required this.nivel,
    // required this.forca,
    // required this.destreza,
    // required this.constituicao,
    // required this.inteligencia,
    // required this.sabedoria,
    // required this.carisma,
  });
}

//Modelo de ficha de personagem D&D
class CharacterSheetDeD extends CharacterSheetUniveresal {
  final String classe;
  final String raca;
  final int nivel;
  final int forca;
  final int destreza;
  final int constituicao;
  final int inteligencia;
  final int sabedoria;
  final int carisma;
  CharacterSheetDeD({
    required String nome,
    required String anotacoes,
    required this.classe,
    required this.raca,
    required this.nivel,
    required this.forca,
    required this.destreza,
    required this.constituicao,
    required this.inteligencia,
    required this.sabedoria,
    required this.carisma,
    }) : super(nome: nome, anotacoes: anotacoes);

  factory CharacterSheetDeD.fromMap(Map<String, dynamic> map) {
    return CharacterSheetDeD(
      nome: map['nome'] ?? '',
      classe: map['classe'] ?? '',
      raca: map['raca'] ?? '',
      nivel:
          map['nivel'] is int
              ? map['nivel']
              : int.tryParse(map['nivel'].toString()) ?? 1,
      forca:
          map['forca'] is int
              ? map['forca']
              : int.tryParse(map['forca'].toString()) ?? 10,
      destreza:
          map['destreza'] is int
              ? map['destreza']
              : int.tryParse(map['destreza'].toString()) ?? 10,
      constituicao:
          map['constituicao'] is int
              ? map['constituicao']
              : int.tryParse(map['constituicao'].toString()) ?? 10,
      inteligencia:
          map['inteligencia'] is int
              ? map['inteligencia']
              : int.tryParse(map['inteligencia'].toString()) ?? 10,
      sabedoria:
          map['sabedoria'] is int
              ? map['sabedoria']
              : int.tryParse(map['sabedoria'].toString()) ?? 10,
      carisma:
          map['carisma'] is int
              ? map['carisma']
              : int.tryParse(map['carisma'].toString()) ?? 10,
      anotacoes: map['anotacoes'] ?? '',
    );
  }

  /// Converte os dados da ficha
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'classe': classe,
      'raca': raca,
      'nivel': nivel,
      'forca': forca,
      'destreza': destreza,
      'constituicao': constituicao,
      'inteligencia': inteligencia,
      'sabedoria': sabedoria,
      'carisma': carisma,
      'anotacoes':anotacoes,
    };
  }
}

//Tela que exibe a lista das fichas salvas
class CharacterSheetListScreen extends StatefulWidget {
  const CharacterSheetListScreen({super.key});

  @override
  _CharacterSheetListScreenState createState() =>
      _CharacterSheetListScreenState();
}

class _CharacterSheetListScreenState extends State<CharacterSheetListScreen> {
  List<CharacterSheetDeD> characterSheets = [];

  @override
  void initState() {
    super.initState();
    _loadCharacterSheets();
  }

  //Carrega as fichas salvas
  Future<void> _loadCharacterSheets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('characterSheets');
    if (data != null) {
      try {
        final List<dynamic> decoded = json.decode(data);
        setState(() {
          characterSheets =
              decoded.map((item) => CharacterSheetDeD.fromMap(item)).toList();
        });
      } catch (e) {
        print("Erro ao decodificar as fichas: $e");
      }
    }
  }

  //Salva a lista de fichas
  Future<void> _saveCharacterSheets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> maps =
        characterSheets.map((cs) => cs.toMap()).toList();
    await prefs.setString('characterSheets', json.encode(maps));
  }

  // Navega para a tela de criação
  void _navigateToNewSheet() async {
    final newSheet = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewCharacterSheetScreen()),
    );
    if (newSheet != null && newSheet is CharacterSheetDeD) {
      setState(() {
        characterSheets.add(newSheet);
      });
      _saveCharacterSheets();
    }
  }

  void _navigateToEditSheet(int index) async {
    final sheetToEdit = characterSheets[index];
    final updatedSheet = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewCharacterSheetScreen(sheet: sheetToEdit),
      ),
    );
    if (updatedSheet != null && updatedSheet is CharacterSheetDeD) {
      setState(() {
        characterSheets[index] = updatedSheet;
      });
      _saveCharacterSheets();
    }
  }

  void _navigateToSheetDetails(CharacterSheetDeD sheet) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterSheetDetailsScreen(sheet: sheet),
      ),
    );
  }

  /// Remove uma ficha da lista.
  void _deleteSheet(int index) {
    setState(() {
      characterSheets.removeAt(index);
    });
    _saveCharacterSheets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minhas Fichas de RPG')),
      body:
          characterSheets.isEmpty
              ? Center(child: Text("Nenhuma ficha encontrada."))
              : ListView.builder(
                itemCount: characterSheets.length,
                itemBuilder: (context, index) {
                  final cs = characterSheets[index];
                  return Card(
                    child: ListTile(
                      title: Text(cs.nome),
                      subtitle: Text('${cs.classe} - Nível ${cs.nivel}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.visibility, color: Colors.blue),
                            onPressed: () => _navigateToSheetDetails(cs),
                            tooltip: "Visualizar",
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => _navigateToEditSheet(index),
                            tooltip: "Editar",
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
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
        child: Icon(Icons.add),
      ),
    );
  }
}

// Tela para criação/edição de uma ficha de personagem
class NewCharacterSheetScreen extends StatefulWidget {
  final CharacterSheetDeD? sheet; // Se fornecido, é modo edição.

  const NewCharacterSheetScreen({super.key, this.sheet});

  @override
  _NewCharacterSheetScreenState createState() =>
      _NewCharacterSheetScreenState();
}

class _NewCharacterSheetScreenState extends State<NewCharacterSheetScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos do formulário.
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
    //Se estiver em modo edição
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
      validator:
          (value) =>
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
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campos de texto para inserir os dados da ficha.
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? 'Informe o nome'
                            : null,
              ),
              TextFormField(
                controller: _classeController,
                decoration: InputDecoration(labelText: 'Classe'),
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? 'Informe a classe'
                            : null,
              ),
              TextFormField(
                controller: _racaController,
                decoration: InputDecoration(labelText: 'Raça'),
                validator:
                    (value) =>
                        (value == null || value.isEmpty)
                            ? 'Informe a raça'
                            : null,
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
                decoration: InputDecoration(labelText: 'Anotações'),

              ),
              SizedBox(height: 20),
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

/// Tela para visualização dos detalhes da ficha em uma tabela.
class CharacterSheetDetailsScreen extends StatelessWidget {
  final CharacterSheetDeD sheet;

  const CharacterSheetDetailsScreen({super.key, required this.sheet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detalhes da Ficha")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                "Atributo",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                "Valor",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: [
            DataRow(
              cells: [DataCell(Text("Nome")), DataCell(Text(sheet.nome))],
            ),
            DataRow(
              cells: [DataCell(Text("Classe")), DataCell(Text(sheet.classe))],
            ),
            DataRow(
              cells: [DataCell(Text("Raça")), DataCell(Text(sheet.raca))],
            ),
            DataRow(
              cells: [
                DataCell(Text("Nível")),
                DataCell(Text(sheet.nivel.toString())),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Força")),
                DataCell(Text(sheet.forca.toString())),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Destreza")),
                DataCell(Text(sheet.destreza.toString())),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Constituição")),
                DataCell(Text(sheet.constituicao.toString())),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Inteligência")),
                DataCell(Text(sheet.inteligencia.toString())),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Sabedoria")),
                DataCell(Text(sheet.sabedoria.toString())),
              ],
            ),
            DataRow(
              cells: [
                DataCell(Text("Carisma")),
                DataCell(Text(sheet.carisma.toString())),
              ],
            ),
            DataRow(
              cells: [DataCell(Text("Anotações")), DataCell(Text(sheet.anotacoes))],
            ),
          ],
        ),
      ),
    );
  }
}
