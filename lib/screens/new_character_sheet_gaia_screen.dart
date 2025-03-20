import 'package:fichasrpg/models/character_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


// Tela para criação/edição de ficha Gaia
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
  String? _selectedHabilidade1;
  String? _selectedHabilidade2;
  String? _selectedHabilidade3;
  String? _selectedHabilidade4;
  String? _selectedHabilidade5;
  String? _selectedHabilidade6;
  String? _selectedArma;
  final _danoArmaController = TextEditingController();
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
      _selectedHabilidade1 = widget.sheet!.habilidade1.isNotEmpty ? widget.sheet!.habilidade1 : null;
      _selectedHabilidade2 = widget.sheet!.habilidade2.isNotEmpty ? widget.sheet!.habilidade2 : null;
      _selectedHabilidade3 = widget.sheet!.habilidade3.isNotEmpty ? widget.sheet!.habilidade3 : null;
      _selectedHabilidade4 = widget.sheet!.habilidade4.isNotEmpty ? widget.sheet!.habilidade4 : null;
      _selectedHabilidade5 = widget.sheet!.habilidade5.isNotEmpty ? widget.sheet!.habilidade5 : null;
      _selectedHabilidade6 = widget.sheet!.habilidade6.isNotEmpty ? widget.sheet!.habilidade6 : null;
      _selectedArma = widget.sheet!.arma.isNotEmpty ? widget.sheet!.arma : null;
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
      _danoArmaController.text = widget.sheet!.danoArma.toString();
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
    _danoArmaController.dispose();
    super.dispose();
  }

  void _saveCharacterSheet() {
  if (_formKey.currentState?.validate() ?? false) {
    final newSheet = CharacterSheetGaia(
      nome: _nomeController.text,
      nivel: int.tryParse(_nivelController.text) ?? 1,
      legado: _selectedLegado??'',
      habilidade1: _selectedHabilidade1??'',
      habilidade2: _selectedHabilidade2??'',
      habilidade3: _selectedHabilidade3??'',
      habilidade4: _selectedHabilidade4??'',
      habilidade5: _selectedHabilidade5??'',
      habilidade6: _selectedHabilidade6??'',
      arma: _selectedArma??'',
      danoArma: int.tryParse(_danoArmaController.text)?? 0,
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
              SizedBox(height: 16),
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
                'HABILIDADES',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                            value: _selectedHabilidade1,
                            decoration: const InputDecoration(
                              labelText: 'Habilidade 1',
                              border: OutlineInputBorder(),
                            ),
                            
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 16,
                            ),
                            items: Habilidades().habilidades
                                .map((habilidade1) => DropdownMenuItem<String>(
                                      value: habilidade1,
                                      child: Text(habilidade1),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedHabilidade1 = value;
                              });
                            },
                            
                            
                          ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                              value: _selectedHabilidade2,
                              decoration: const InputDecoration(
                                labelText: 'Habilidade 2',
                                border: OutlineInputBorder(),
                              ),
                              
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                fontSize: 16,
                              ),
                              items: Habilidades().habilidades
                                  .map((habilidades) => DropdownMenuItem<String>(
                                        value: habilidades,
                                        child: Text(habilidades),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedHabilidade2 = value;
                                });
                              },
                              
                            ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                            value: _selectedHabilidade3,
                            decoration: const InputDecoration(
                              labelText: 'Habilidade 3',
                              border: OutlineInputBorder(),
                            ),
                            
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 16,
                            ),
                            items: Habilidades().habilidades
                                .map((habilidades) => DropdownMenuItem<String>(
                                      value: habilidades,
                                      child: Text(habilidades),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedHabilidade3 = value;
                              });
                            },
                            
                          ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                              value: _selectedHabilidade4,
                              decoration: const InputDecoration(
                                labelText: 'Habilidade 4',
                                border: OutlineInputBorder(),
                              ),
                              
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                fontSize: 16,
                              ),
                              items: Habilidades().habilidades
                                  .map((habilidades) => DropdownMenuItem<String>(
                                        value: habilidades,
                                        child: Text(habilidades),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedHabilidade4 = value;
                                });
                              },
                  
                            ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                            value: _selectedHabilidade5,
                            decoration: const InputDecoration(
                              labelText: 'Habilidade 5',
                              border: OutlineInputBorder(),
                            ),
                            
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                              fontSize: 16,
                            ),
                            items: Habilidades().habilidades
                                .map((habilidades) => DropdownMenuItem<String>(
                                      value: habilidades,
                                      child: Text(habilidades),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedHabilidade5 = value;
                              });
                            },
                            
                          ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                              value: _selectedHabilidade6,
                              decoration: const InputDecoration(
                                labelText: 'Habilidade 6',
                                border: OutlineInputBorder(),
                              ),
                              
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 16,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                fontSize: 16,
                              ),
                              items: Habilidades().habilidades
                                  .map((habilidades) => DropdownMenuItem<String>(
                                        value: habilidades,
                                        child: Text(habilidades),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedHabilidade6 = value;
                                });
                              },
                              
                            ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: 
                    DropdownButtonFormField<String>(
                      value: _selectedArma,
                      decoration: const InputDecoration(
                        labelText: 'Arma',
                        border: OutlineInputBorder(),
                      ),
                      
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 16,
                      ),
                      items: Armas().armas
                          .map((armas) => DropdownMenuItem<String>(
                                value: armas,
                                child: Text(armas),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedArma = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(child: _buildNumberField(_danoArmaController, 'Modificador'),)
                ],
              ),
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
                      habilidade1: _selectedHabilidade1??'',
                      habilidade2: _selectedHabilidade2??'',
                      habilidade3: _selectedHabilidade3??'',
                      habilidade4: _selectedHabilidade4??'',
                      habilidade5: _selectedHabilidade5??'',
                      habilidade6: _selectedHabilidade6??'',
                      arma: _selectedArma??'',
                      danoArma: int.tryParse(_danoArmaController.text)?? 0,
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
