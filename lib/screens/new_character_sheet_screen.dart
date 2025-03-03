import 'package:fichasrpg/models/character_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// Tela para criação/edição de ficha D&D (já existente)
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