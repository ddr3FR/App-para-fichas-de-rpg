import 'package:fichasrpg/models/character_sheet.dart';
import 'package:flutter/material.dart';

class CharacterSheetDetailsScreen extends StatelessWidget {
  final CharacterSheetUniveresal sheet;
  const CharacterSheetDetailsScreen({Key? key, required this.sheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes da Ficha")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBasicInfoCard(context),
            if (sheet is CharacterSheetDeD) ...[
              _buildDnDAttributesCard(context, sheet as CharacterSheetDeD),
              _buildDnDSkillsCard(context, sheet as CharacterSheetDeD),
              _buildDnDPersonalityCard(context, sheet as CharacterSheetDeD),
            ] else if (sheet is CharacterSheetGaia) ...[
              _buildGaiaParametrosCard(context, sheet as CharacterSheetGaia),
              _buildGaiaAttributesCard(context, sheet as CharacterSheetGaia),
              _buildGaiaSkillsCard(context, sheet as CharacterSheetGaia),
            ],
            _buildNotesCard(context, sheet.anotacoes),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoCard(BuildContext context) {
    List<Widget> infoRows = [
      _buildInfoRow("Nome", sheet.nome),
      _buildInfoRow("Nível", sheet.nivel.toString()),
    ];

    if (sheet is CharacterSheetDeD) {
      final dnd = sheet as CharacterSheetDeD;
      infoRows.addAll([
        _buildInfoRow("Classe", dnd.classe),
        _buildInfoRow("Raça", dnd.raca),
        _buildInfoRow("Alinhamento", dnd.alinhamento),
        _buildInfoRow("Antecedentes", dnd.antecedente),
        _buildInfoRow("Exp", dnd.exp.toString()),
        _buildInfoRow("CA", dnd.cA.toString()),
        _buildInfoRow("Deslocamento", dnd.deslocamento.toString()),
        _buildInfoRow("Iniciativa", dnd.iniciativa.toString()),
      ]);
    } else if (sheet is CharacterSheetGaia) {
      final gaia = sheet as CharacterSheetGaia;
      // Removemos "Precisão" e "Brutalidade" daqui para exibi-los no card de Parâmetros
      infoRows.addAll([
        _buildInfoRow("Legador", gaia.legado),
        _buildInfoRow("Vida", gaia.vida.toString()),
        _buildInfoRow("PE", gaia.pe.toString()),
        _buildInfoRow("Movimentação", gaia.movimentacao.toString()),
        _buildInfoRow("Bloqueio", gaia.bloqueio.toString()),
      ]);
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Informações Básicas",
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            ...infoRows,
          ],
        ),
      ),
    );
  }

  Widget _buildGaiaParametrosCard(BuildContext context, CharacterSheetGaia gaia) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Parâmetros",
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildInfoRow("Precisão", gaia.precisao.toString()),
            _buildInfoRow("Brutalidade", gaia.brutalidade.toString()),
            _buildInfoRow("Destreza", gaia.destreza.toString()),
            _buildInfoRow("Agilidade", gaia.agilidade.toString()),
            _buildInfoRow("Canalização", gaia.canalizacao.toString()),
            _buildInfoRow("Arcanismo", gaia.arcanismo.toString()),
            _buildInfoRow("Espírito", gaia.espirito.toString()),
            _buildInfoRow("Vigor", gaia.vigor.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildDnDAttributesCard(BuildContext context, CharacterSheetDeD dnd) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Atributos",
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildInfoRow("Força", dnd.forca.toString()),
            _buildInfoRow("Destreza", dnd.destreza.toString()),
            _buildInfoRow("Constituição", dnd.constituicao.toString()),
            _buildInfoRow("Inteligência", dnd.inteligencia.toString()),
            _buildInfoRow("Sabedoria", dnd.sabedoria.toString()),
            _buildInfoRow("Carisma", dnd.carisma.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildDnDSkillsCard(BuildContext context, CharacterSheetDeD dnd) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Perícias",
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildInfoRow("Atletismo", dnd.atletismo.toString()),
            _buildInfoRow("Acrobacia", dnd.acrobacia.toString()),
            _buildInfoRow("Furtividade", dnd.furtividade.toString()),
            _buildInfoRow("Prestidigitação", dnd.prestidigitacao.toString()),
            _buildInfoRow("Atuação", dnd.atuacao.toString()),
            _buildInfoRow("Enganação", dnd.enganacao.toString()),
            _buildInfoRow("Intimidação", dnd.intimidacao.toString()),
            _buildInfoRow("Persuasão", dnd.persuasao.toString()),
            _buildInfoRow("Arcanismo", dnd.arcanismo.toString()),
            _buildInfoRow("História", dnd.historia.toString()),
            _buildInfoRow("Investigação", dnd.investigacao.toString()),
            _buildInfoRow("Natureza", dnd.natureza.toString()),
            _buildInfoRow("Religião", dnd.religiao.toString()),
            _buildInfoRow("Intuição", dnd.intuicao.toString()),
            _buildInfoRow("Lidar Com Animais", dnd.adestrarAnimais.toString()),
            _buildInfoRow("Medicina", dnd.medicina.toString()),
            _buildInfoRow("Percepção", dnd.percepcao.toString()),
            _buildInfoRow("Sobrevivência", dnd.sobrevivencia.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildDnDPersonalityCard(BuildContext context, CharacterSheetDeD dnd) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Personalidade",
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildAnnotationField("Traços de Personalidade", dnd.tracosDePers),
            _buildAnnotationField("Ideais", dnd.ideais),
            _buildAnnotationField("Ligações", dnd.ligacoes),
            _buildAnnotationField("Defeitos", dnd.defeitos),
          ],
        ),
      ),
    );
  }

  Widget _buildGaiaAttributesCard(BuildContext context, CharacterSheetGaia gaia) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Conhecimentos",
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildInfoRow("Carisma", gaia.carisma.toString()),
            _buildInfoRow("Medicina", gaia.medicina.toString()),
            _buildInfoRow("Con. Místicos", gaia.conhecimentosMisticos.toString()),
            _buildInfoRow("Percepção", gaia.percepcao.toString()),
            _buildInfoRow("Exploração", gaia.exploracao.toString()),
            _buildInfoRow("Performance", gaia.performance.toString()),
            _buildInfoRow("Furtividade", gaia.furtividade.toString()),
            _buildInfoRow("Religião", gaia.religiao.toString()),
            _buildInfoRow("História", gaia.historia.toString()),
            _buildInfoRow("Sobrevivência", gaia.sobrevivencia.toString()),
            _buildInfoRow("Intimidação", gaia.intimidacao.toString()),
            _buildInfoRow("Tecnologia", gaia.tecnologia.toString()),
            _buildInfoRow("Intuição", gaia.intuicao.toString()),
            _buildInfoRow("Vontade", gaia.vontade.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildGaiaSkillsCard(BuildContext context, CharacterSheetGaia gaia) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Habilidades",
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            _buildInfoRow("Habilidade 1", gaia.habilidade1.toString()),
            _buildInfoRow("Habilidade 2", gaia.habilidade2.toString()),
            _buildInfoRow("Habilidade 3", gaia.habilidade3.toString()),
            _buildInfoRow("Habilidade 4", gaia.habilidade4.toString()),
            _buildInfoRow("Habilidade 5", gaia.habilidade5.toString()),
            _buildInfoRow("Habilidade 6", gaia.habilidade6.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context, String notes) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Anotações",
                style: Theme.of(context).textTheme.titleLarge),
            const Divider(),
            Text(notes),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildAnnotationField(String title, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(text, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
