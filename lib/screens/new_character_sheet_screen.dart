import 'package:fichasrpg/models/character_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Tela para criação/edição de ficha D&D
class NewCharacterSheetScreen extends StatefulWidget {
  final CharacterSheetDeD? sheet;
  const NewCharacterSheetScreen({super.key, this.sheet});
  @override
  _NewCharacterSheetScreenState createState() =>
      _NewCharacterSheetScreenState();
}

class _NewCharacterSheetScreenState extends State<NewCharacterSheetScreen> {
  final _formKey = GlobalKey<FormState>();

  ///Infomações de bases
  final _nomeController = TextEditingController();
  String? _classeController;
  String? _racaController;
  final _antecedenteController = TextEditingController();
  final _alinhamentoController = TextEditingController();
  final _nivelController = TextEditingController();
  final _exp = TextEditingController();
  final _cAController = TextEditingController();
  final _deslocamentoController = TextEditingController();
  final _iniciativaController = TextEditingController();
  final _tracosDePersController = TextEditingController();
  final _ideaisController = TextEditingController();
  final _ligacoesController = TextEditingController();
  final _defeitosController = TextEditingController();
  final _anotacoesController = TextEditingController();

  ///Infomações de atributo
  final _forcaController = TextEditingController();
  final _destrezaController = TextEditingController();
  final _constituicaoController = TextEditingController();
  final _inteligenciaController = TextEditingController();
  final _sabedoriaController = TextEditingController();
  final _carismaController = TextEditingController();

  ///Infomações de pericias
  final _bonusDeProef = TextEditingController();
  final _inspiracao = TextEditingController();
  final _acrobaciaController = TextEditingController();
  final _adestrarAnimaisController = TextEditingController();
  final _arcanismoController = TextEditingController();
  final _atletismoController = TextEditingController();
  final _atuacaoController = TextEditingController();
  final _blefarController = TextEditingController();
  final _enganacaoController = TextEditingController();
  final _furtividadeController = TextEditingController();
  final _historiaController = TextEditingController();
  final _intimidacaoController = TextEditingController();
  final _intuicaoController = TextEditingController();
  final _investigacaoController = TextEditingController();
  final _medicinaController = TextEditingController();
  final _naturezaController = TextEditingController();
  final _percepcaoController = TextEditingController();
  final _persuasaoController = TextEditingController();
  final _prestidigitacaoController = TextEditingController();
  final _religiaoController = TextEditingController();
  final _sobrevivenciaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.sheet != null) {
      ///Infomações de bases
      _nomeController.text = widget.sheet!.nome;
      _classeController = widget.sheet!.classe;
      _racaController = widget.sheet!.raca;
      _nivelController.text = widget.sheet!.nivel.toString();
      _exp.text = widget.sheet!.exp.toString();
      _alinhamentoController.text = widget.sheet!.alinhamento;
      _antecedenteController.text = widget.sheet!.antecedente;
      _cAController.text = widget.sheet!.cA.toString();
      _deslocamentoController.text = widget.sheet!.deslocamento.toString();
      _iniciativaController.text = widget.sheet!.iniciativa.toString();
      _tracosDePersController.text = widget.sheet!.tracosDePers;
      _ideaisController.text = widget.sheet!.ideais;
      _ligacoesController.text = widget.sheet!.ligacoes;
      _defeitosController.text = widget.sheet!.defeitos;
      _anotacoesController.text = widget.sheet!.anotacoes;

      ///Infomações de atributo
      _forcaController.text = widget.sheet!.forca.toString();
      _destrezaController.text = widget.sheet!.destreza.toString();
      _constituicaoController.text = widget.sheet!.constituicao.toString();
      _inteligenciaController.text = widget.sheet!.inteligencia.toString();
      _sabedoriaController.text = widget.sheet!.sabedoria.toString();
      _carismaController.text = widget.sheet!.carisma.toString();

      ///Infomações de pericias
      _bonusDeProef.text = widget.sheet!.bonusDeProef.toString();
      _inspiracao.text = widget.sheet!.inspiracao.toString();
      _acrobaciaController.text = widget.sheet!.acrobacia.toString();
      _adestrarAnimaisController.text =
          widget.sheet!.adestrarAnimais.toString();
      _arcanismoController.text = widget.sheet!.arcanismo.toString();
      _atletismoController.text = widget.sheet!.atletismo.toString();
      _atuacaoController.text = widget.sheet!.atuacao.toString();
      _blefarController.text = widget.sheet!.blefar.toString();
      _enganacaoController.text = widget.sheet!.enganacao.toString();
      _furtividadeController.text = widget.sheet!.furtividade.toString();
      _historiaController.text = widget.sheet!.historia.toString();
      _intimidacaoController.text = widget.sheet!.intimidacao.toString();
      _intuicaoController.text = widget.sheet!.intuicao.toString();
      _investigacaoController.text = widget.sheet!.investigacao.toString();
      _medicinaController.text = widget.sheet!.medicina.toString();
      _naturezaController.text = widget.sheet!.natureza.toString();
      _percepcaoController.text = widget.sheet!.percepcao.toString();
      _persuasaoController.text = widget.sheet!.persuasao.toString();
      _prestidigitacaoController.text =
          widget.sheet!.prestidigitacao.toString();
      _religiaoController.text = widget.sheet!.religiao.toString();
      _sobrevivenciaController.text = widget.sheet!.sobrevivencia.toString();
    }
  }

  @override
  void dispose() {
    ///Infomações de bases
    _nomeController.dispose();
    _nivelController.dispose();
    _exp.dispose();
    _antecedenteController.dispose();
    _alinhamentoController.dispose();
    _cAController.dispose();
    _deslocamentoController.dispose();
    _iniciativaController.dispose();
    _tracosDePersController.dispose();
    _ideaisController.dispose();
    _ligacoesController.dispose();
    _defeitosController.dispose();
    _anotacoesController.dispose();

    ///Infomações de atributo
    _forcaController.dispose();
    _destrezaController.dispose();
    _constituicaoController.dispose();
    _inteligenciaController.dispose();
    _sabedoriaController.dispose();
    _carismaController.dispose();

    ///Infomações de pericias
    _bonusDeProef.dispose();
    _inspiracao.dispose();
    _acrobaciaController.dispose();
    _adestrarAnimaisController.dispose();
    _arcanismoController.dispose();
    _atletismoController.dispose();
    _atuacaoController.dispose();
    _blefarController.dispose();
    _enganacaoController.dispose();
    _furtividadeController.dispose();
    _historiaController.dispose();
    _intimidacaoController.dispose();
    _intuicaoController.dispose();
    _investigacaoController.dispose();
    _medicinaController.dispose();
    _naturezaController.dispose();
    _percepcaoController.dispose();
    _persuasaoController.dispose();
    _prestidigitacaoController.dispose();
    _religiaoController.dispose();
    _sobrevivenciaController.dispose();
    super.dispose();
  }

  void _saveCharacterSheet() {
    if (_formKey.currentState?.validate() ?? false) {
      final newSheet = CharacterSheetDeD(
        ///Infomações de bases
        nome: _nomeController.text,
        classe: _classeController ?? '',
        raca: _racaController ?? '',
        nivel: int.tryParse(_nivelController.text) ?? 1,
        exp: int.tryParse(_exp.text) ?? 1,
        alinhamento: _alinhamentoController.text,
        antecedente: _antecedenteController.text,
        cA: int.tryParse(_cAController.text) ?? 1,
        deslocamento: int.tryParse(_deslocamentoController.text) ?? 1,
        iniciativa: int.tryParse(_iniciativaController.text) ?? 1,
        tracosDePers: _tracosDePersController.text,
        ideais: _ideaisController.text,
        ligacoes: _ligacoesController.text,
        defeitos: _defeitosController.text,
        anotacoes: _anotacoesController.text,

        ///Infomações de atributo
        forca: int.tryParse(_forcaController.text) ?? 10,
        destreza: int.tryParse(_destrezaController.text) ?? 10,
        constituicao: int.tryParse(_constituicaoController.text) ?? 10,
        inteligencia: int.tryParse(_inteligenciaController.text) ?? 10,
        sabedoria: int.tryParse(_sabedoriaController.text) ?? 10,
        carisma: int.tryParse(_carismaController.text) ?? 10,

        ///Infomações de pericias
        bonusDeProef: int.tryParse(_bonusDeProef.text) ?? 1,
        inspiracao: int.tryParse(_inspiracao.text) ?? 1,
        acrobacia: int.tryParse(_acrobaciaController.text) ?? 10,
        adestrarAnimais: int.tryParse(_adestrarAnimaisController.text) ?? 10,
        arcanismo: int.tryParse(_arcanismoController.text) ?? 10,
        atletismo: int.tryParse(_atletismoController.text) ?? 10,
        atuacao: int.tryParse(_atuacaoController.text) ?? 10,
        blefar: int.tryParse(_blefarController.text) ?? 10,
        enganacao: int.tryParse(_enganacaoController.text) ?? 10,
        furtividade: int.tryParse(_furtividadeController.text) ?? 10,
        historia: int.tryParse(_historiaController.text) ?? 10,
        intimidacao: int.tryParse(_intimidacaoController.text) ?? 10,
        intuicao: int.tryParse(_intuicaoController.text) ?? 10,
        investigacao: int.tryParse(_investigacaoController.text) ?? 10,
        medicina: int.tryParse(_medicinaController.text) ?? 10,
        natureza: int.tryParse(_naturezaController.text) ?? 10,
        percepcao: int.tryParse(_percepcaoController.text) ?? 10,
        persuasao: int.tryParse(_persuasaoController.text) ?? 10,
        prestidigitacao: int.tryParse(_prestidigitacaoController.text) ?? 10,
        religiao: int.tryParse(_religiaoController.text) ?? 10,
        sobrevivencia: int.tryParse(_sobrevivenciaController.text) ?? 10,
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator:
                          (value) =>
                              (value == null || value.isEmpty)
                                  ? 'Informe o nome'
                                  : null,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(child: _buildNumberField(_nivelController, 'Nível')),
                ],
              ),
              const SizedBox(width: 16.0),
              Row(
                children: [
                  Expanded(child: _buildNumberField(_exp, "EXP")),
                  const SizedBox(width: 16.0),
                  Expanded(child: _buildNumberField(_cAController, 'CA')),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(
                      _deslocamentoController,
                      'Deslocamento',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(
                      _iniciativaController,
                      'Iniciativa',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      maxLines: 1,
                      controller: _alinhamentoController,
                      decoration: const InputDecoration(labelText: 'Alinhamento'),
              ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      maxLines: 1,
                      controller: _antecedenteController,
                      decoration: const InputDecoration(labelText: 'Antecedentes'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _classeController,
                      decoration: const InputDecoration(
                        labelText: 'Classe',
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 16,
                      ),
                      items:
                          ListaDeClasses().listaDeClasses
                              .map(
                                (classe) => DropdownMenuItem<String>(
                                  value: classe,
                                  child: Text(classe),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          _classeController = value;
                        });
                      },
                      validator:
                          (value) =>
                              value == null ? 'Selecione uma Classe' : null,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _racaController,
                      decoration: const InputDecoration(
                        labelText: 'Raça',
                        border: OutlineInputBorder(),
                      ),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 16,
                      ),
                      items:
                          ListaDeRacas().listaDeRacas
                              .map(
                                (raca) => DropdownMenuItem<String>(
                                  value: raca,
                                  child: Text(raca),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          _racaController = value;
                        });
                      },
                      validator:
                          (value) => value == null ? 'Selecione um Raça' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                'ATRIBUTOS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Row(
                children: [
                  Expanded(child: _buildNumberField(_forcaController, 'Força')),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(_destrezaController, 'Destreza'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(
                      _constituicaoController,
                      'Constituição',
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16.0),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(
                      _inteligenciaController,
                      'Inteligência',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(_sabedoriaController, 'Sabedoria'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(_carismaController, 'Carisma'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Divider(
                color: Colors.grey, // Cor da linha
                thickness: 3, // Espessura da linha
                indent: 0, // Espaçamento à esquerda
                endIndent: 0, // Espaçamento à direita
              ),
              Text(
                'PERICIAS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(_bonusDeProef, 'Bonus de Proef.'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(child: _buildNumberField(_inspiracao, 'Inspiração')),
                ],
              ),
              const SizedBox(width: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text('Força:', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(_atletismoController, 'Atletismo'),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 3,
                indent: 0,
                endIndent: 0,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text('Destreza', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text('Carisma', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(_acrobaciaController, 'Acrobacia'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(_atuacaoController, 'Atuação'),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(
                      _furtividadeController,
                      'Furtividade',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(_enganacaoController, 'Enganação'),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(
                      _prestidigitacaoController,
                      'Prestidigitação',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(
                      _intimidacaoController,
                      'Intimidação',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              Row(
                children: [
                  Expanded(child: Text('')),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(_persuasaoController, 'Persuasão'),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 3,
                indent: 0,
                endIndent: 0,
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: Text('Inteligência', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Text('Sabedoria', style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(_arcanismoController, 'Arcanismo'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(_intuicaoController, 'Intuição'),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(_historiaController, 'História'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(
                      _adestrarAnimaisController,
                      'Lidar com Animais',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(
                      _investigacaoController,
                      'Investigação',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(_medicinaController, 'Medicina'),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(_naturezaController, 'Naturaza'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(_percepcaoController, 'Percepção'),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildNumberField(_religiaoController, 'Religião'),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildNumberField(
                      _sobrevivenciaController,
                      'Sobrevivência',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                ],
              ),
              const SizedBox(height: 16.0),
              Divider(
                color: Colors.grey,
                thickness: 3,
                indent: 0,
                endIndent: 0,
              ),
              Text(
                'Peronalidade e Outros',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              TextFormField(
                maxLines: 3,
                controller: _tracosDePersController,
                decoration: const InputDecoration(
                  labelText: 'Traços de Personalidade',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                maxLines: 3,
                controller: _ideaisController,
                decoration: const InputDecoration(labelText: 'Ideais'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                maxLines: 3,
                controller: _ligacoesController,
                decoration: const InputDecoration(labelText: 'Ligações'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                maxLines: 3,
                controller: _defeitosController,
                decoration: const InputDecoration(labelText: 'Defeitos'),
              ),
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
