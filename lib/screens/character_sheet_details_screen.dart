import 'package:fichasrpg/models/character_sheet.dart';
import 'package:flutter/material.dart';

// Tela de detalhes da ficha (diferencia D&D e Gaia)
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
      
      rows.insert(0, DataRow(cells: [DataCell(Text("Classe")), DataCell(Text(dnd.classe))]));
      rows.insert(1, DataRow(cells: [DataCell(Text("Raça")), DataCell(Text(dnd.raca))]));
      rows.insert(2, DataRow(cells: [DataCell(Text("Força")), DataCell(Text(dnd.forca.toString()))]));
      rows.insert(3, DataRow(cells: [DataCell(Text("Destreza")), DataCell(Text(dnd.destreza.toString()))]));
      rows.insert(4, DataRow(cells: [DataCell(Text("Constituição")), DataCell(Text(dnd.constituicao.toString()))]));
      rows.insert(5, DataRow(cells: [DataCell(Text("Inteligência")), DataCell(Text(dnd.inteligencia.toString()))]));
      rows.insert(6, DataRow(cells: [DataCell(Text("Sabedoria")), DataCell(Text(dnd.sabedoria.toString()))]));
      rows.insert(7, DataRow(cells: [DataCell(Text("Carisma")), DataCell(Text(dnd.carisma.toString()))]));
    } else if (sheet is CharacterSheetGaia) {
      final gaia = sheet as CharacterSheetGaia;
      rows.insert(2,DataRow(cells: [DataCell(Text("Legador")), DataCell(Text(gaia.legado))]));
      rows.insert(3, DataRow(cells: [DataCell(Text("Vida")), DataCell(Text(gaia.vida.toString()))]));
      rows.insert(4, DataRow(cells: [DataCell(Text("PE")), DataCell(Text(gaia.pe.toString()))]));
      rows.insert(5, DataRow(cells: [DataCell(Text("Movimentação")), DataCell(Text(gaia.movimentacao.toString()))]));
      rows.insert(6, DataRow(cells: [DataCell(Text("Bloqueio")), DataCell(Text(gaia.bloqueio.toString()))]));
      rows.insert(7, DataRow(cells: [DataCell(Text("Precisão")), DataCell(Text(gaia.precisao.toString()))]));
      rows.insert(8, DataRow(cells: [DataCell(Text("Brutalidade")), DataCell(Text(gaia.brutalidade.toString()))]));
      rows.insert(9, DataRow(cells: [DataCell(Text("Destreza")), DataCell(Text(gaia.destreza.toString()))]));
      rows.insert(10, DataRow(cells: [DataCell(Text("Agilidade")), DataCell(Text(gaia.agilidade.toString()))]));
      rows.insert(11, DataRow(cells: [DataCell(Text("Canalizção")), DataCell(Text(gaia.canalizacao.toString()))]));
      rows.insert(12, DataRow(cells: [DataCell(Text("Arcanismo")), DataCell(Text(gaia.arcanismo.toString()))]));
      rows.insert(13, DataRow(cells: [DataCell(Text("Espirito")), DataCell(Text(gaia.espirito.toString()))]));
      rows.insert(14, DataRow(cells: [DataCell(Text("Vigor")), DataCell(Text(gaia.vigor.toString()))]));
      rows.insert(15, DataRow(cells: [DataCell(Text("Carisma")), DataCell(Text(gaia.carisma.toString()))]));
      rows.insert(16, DataRow(cells: [DataCell(Text("Medicina")), DataCell(Text(gaia.medicina.toString()))]));
      rows.insert(17, DataRow(cells: [DataCell(Text("Con. Misticos")), DataCell(Text(gaia.conhecimentosMisticos.toString()))]));
      rows.insert(18, DataRow(cells: [DataCell(Text("Percepção")), DataCell(Text(gaia.percepcao.toString()))]));
      rows.insert(19, DataRow(cells: [DataCell(Text("Exploração")), DataCell(Text(gaia.exploracao.toString()))]));
      rows.insert(20, DataRow(cells: [DataCell(Text("Performance")), DataCell(Text(gaia.performance.toString()))]));
      rows.insert(21, DataRow(cells: [DataCell(Text("Furtividade")), DataCell(Text(gaia.furtividade.toString()))]));
      rows.insert(22, DataRow(cells: [DataCell(Text("Religião")), DataCell(Text(gaia.religiao.toString()))]));
      rows.insert(23, DataRow(cells: [DataCell(Text("História")), DataCell(Text(gaia.historia.toString()))]));
      rows.insert(24, DataRow(cells: [DataCell(Text("Sobrevivência")), DataCell(Text(gaia.sobrevivencia.toString()))]));
      rows.insert(25, DataRow(cells: [DataCell(Text("Intimidação")), DataCell(Text(gaia.intimidacao.toString()))]));
      rows.insert(26, DataRow(cells: [DataCell(Text("Tecnologia")), DataCell(Text(gaia.tecnologia.toString()))]));
      rows.insert(27, DataRow(cells: [DataCell(Text("Intuição")), DataCell(Text(gaia.intuicao.toString()))]));
      rows.insert(28, DataRow(cells: [DataCell(Text("Vontade")), DataCell(Text(gaia.vontade.toString()))]));
      
      rows.insert(29, DataRow(cells: [DataCell(Text("Habilidade 1")), DataCell(Text(gaia.habilidade1.toString()))]));
      rows.insert(30, DataRow(cells: [DataCell(Text("Habilidade 2")), DataCell(Text(gaia.habilidade2.toString()))]));
      rows.insert(31, DataRow(cells: [DataCell(Text("Habilidade 3")), DataCell(Text(gaia.habilidade3.toString()))]));
      rows.insert(32, DataRow(cells: [DataCell(Text("Habilidade 4")), DataCell(Text(gaia.habilidade4.toString()))]));
      rows.insert(33, DataRow(cells: [DataCell(Text("Habilidade 5")), DataCell(Text(gaia.habilidade5.toString()))]));
      rows.insert(34, DataRow(cells: [DataCell(Text("Habilidade 6")), DataCell(Text(gaia.habilidade6.toString()))]));
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes da Ficha")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('INFORMAÇÕES BASICAS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            DataTable(          
              columns: const [
                
                DataColumn(label: Text("Atributo", style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text("Valor", style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: rows,
            ),
          ],
        ),
      ),
    );
  }
}