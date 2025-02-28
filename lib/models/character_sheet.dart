
/// Classe base para as fichas
abstract class CharacterSheetUniveresal {
  final String nome;
  final String anotacoes;
  final int nivel;
  CharacterSheetUniveresal({
    required this.nome,
    required this.anotacoes,
    required this.nivel,
  });

  Map<String, dynamic> toMap();
}



/// Ficha de personagem D&D
class CharacterSheetDeD extends CharacterSheetUniveresal {
  final String classe;
  final String raca;
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
    required int nivel,
    required this.forca,
    required this.destreza,
    required this.constituicao,
    required this.inteligencia,
    required this.sabedoria,
    required this.carisma,
  }) : super(nome: nome, anotacoes: anotacoes, nivel: nivel);

  factory CharacterSheetDeD.fromMap(Map<String, dynamic> map) {
    return CharacterSheetDeD(
      nome: map['nome'] ?? '',
      classe: map['classe'] ?? '',
      raca: map['raca'] ?? '',
      nivel: map['nivel'] is int
          ? map['nivel']
          : int.tryParse(map['nivel'].toString()) ?? 1,
      forca: map['forca'] is int
          ? map['forca']
          : int.tryParse(map['forca'].toString()) ?? 10,
      destreza: map['destreza'] is int
          ? map['destreza']
          : int.tryParse(map['destreza'].toString()) ?? 10,
      constituicao: map['constituicao'] is int
          ? map['constituicao']
          : int.tryParse(map['constituicao'].toString()) ?? 10,
      inteligencia: map['inteligencia'] is int
          ? map['inteligencia']
          : int.tryParse(map['inteligencia'].toString()) ?? 10,
      sabedoria: map['sabedoria'] is int
          ? map['sabedoria']
          : int.tryParse(map['sabedoria'].toString()) ?? 10,
      carisma: map['carisma'] is int
          ? map['carisma']
          : int.tryParse(map['carisma'].toString()) ?? 10,
      anotacoes: map['anotacoes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': 'dnd',
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
      'anotacoes': anotacoes,
    };
  }
}

/// Ficha de personagem Gaia 
class Legados {
  final List<String> legados = ['ALRAUNES', 'ELFOS', 'MINOTAUROS', 'NETUNES', 'ANÕES', 'DAEVAS', 'URSARS', 'VALDRAKS', 'HUMANOS', 'DELAHKS', 'DRAENUNS', 'KITARIS', 'ORKRASHS', 'INARIS', 'SEIKOS', 'YUANSUS', 'ZAOKANS', 'ELEMENTAIS', 'FORJADOS', 'KAHATS´ZAS', 'VENNÉLIS'];
} 

class CharacterSheetGaia extends CharacterSheetUniveresal {
  final String legado;
  final int vida;
  final int pe;
  final int movimentacao;
  final int bloqueio;
  final int precisao;
  final int brutalidade;
  final int destreza;
  final int agilidade;
  CharacterSheetGaia({
    required this.legado,
    required this.vida,
    required this.pe,
    required this.movimentacao,
    required this.bloqueio,
    required this.precisao,
    required this.brutalidade,
    required this.destreza,
    required this.agilidade,
    required this.canalizacao,
    required this.arcanismo,
    required this.espirito,
    required this.vigor,
    required this.carisma,
    required this.medicina,
    required this.conhecimentosMisticos,
    required this.percepcao,
    required this.exploracao,
    required this.performance,
    required this.furtividade,
    required this.religiao,
    required this.historia,
    required this.sobrevivencia,
    required this.intimidacao,
    required this.tecnologia,
    required this.intuicao,
    required this.vontade,
    required String nome,
    required String anotacoes,
    required int nivel,
  }) : super(nome: nome, anotacoes: anotacoes, nivel: nivel);

  final int canalizacao;
  final int arcanismo;
  final int espirito;
  final int vigor;
  final int carisma;
  final int medicina;
  final int conhecimentosMisticos;
  final int percepcao;
  final int exploracao;
  final int performance;
  final int furtividade;
  final int religiao;
  final int historia;
  final int sobrevivencia;
  final int intimidacao;
  final int tecnologia;
  final int intuicao;
  final int vontade;

  factory CharacterSheetGaia.fromMap(Map<String, dynamic> map) {
    return CharacterSheetGaia(
      nome: map['nome'] ?? '',
      legado: map['legado'] ?? '',
      nivel: map['nivel'] is int
          ? map['nivel']
          : int.tryParse(map['nivel'].toString()) ?? 1,
      vida: map['vida'] is int
          ? map['vida']
          : int.tryParse(map['vida'].toString()) ?? 1,
      pe: map['pe'] is int
          ? map['pe']
          : int.tryParse(map['pe'].toString()) ?? 1,
      movimentacao: map['movimentacao'] is int
          ? map['movimentacao']
          : int.tryParse(map['movimentacao'].toString()) ?? 1,
      bloqueio: map['bloqueio'] is int
          ? map['bloqueio']
          : int.tryParse(map['bloqueio'].toString()) ?? 1,
      precisao: map['precisao'] is int
          ? map['precisao']
          : int.tryParse(map['precisao'].toString()) ?? 1,
      brutalidade: map['brutalidade'] is int
          ? map['brutalidade']
          : int.tryParse(map['brutalidade'].toString()) ?? 1,
      destreza: map['destreza'] is int
          ? map['destreza']
          : int.tryParse(map['destreza'].toString()) ?? 1,
      agilidade: map['agilidade'] is int
          ? map['agilidade']
          : int.tryParse(map['agilidade'].toString()) ?? 1,
      canalizacao: map['canalizacao'] is int
          ? map['canalizacao']
          : int.tryParse(map['canalizacao'].toString()) ?? 1,
      arcanismo: map['arcanismo'] is int
          ? map['arcanismo']
          : int.tryParse(map['arcanismo'].toString()) ?? 1,
      espirito: map['espirito'] is int
          ? map['espirito']
          : int.tryParse(map['espirito'].toString()) ?? 1,
      vigor: map['vigor'] is int
          ? map['vigor']
          : int.tryParse(map['vigor'].toString()) ?? 1,
      carisma: map['carisma'] is int
          ? map['carisma']
          : int.tryParse(map['carisma'].toString()) ?? 1,
      medicina: map['medicina'] is int
          ? map['medicina']
          : int.tryParse(map['medicina'].toString()) ?? 1,
      conhecimentosMisticos: map['conhecimentosMisticos'] is int
          ? map['conhecimentosMisticos']
          : int.tryParse(map['conhecimentosMisticos'].toString()) ?? 1,
      percepcao: map['percepcao'] is int
          ? map['percepcao']
          : int.tryParse(map['percepcao'].toString()) ?? 1,
      exploracao: map['exploracao'] is int
          ? map['exploracao']
          : int.tryParse(map['exploracao'].toString()) ?? 1,
      performance: map['performance'] is int
          ? map['performance']
          : int.tryParse(map['performance'].toString()) ?? 1,
      furtividade: map['furtividade'] is int
          ? map['furtividade']
          : int.tryParse(map['furtividade'].toString()) ?? 1,
      religiao: map['religiao'] is int
          ? map['religiao']
          : int.tryParse(map['religiao'].toString()) ?? 1,
      historia: map['historia'] is int
          ? map['historia']
          : int.tryParse(map['historia'].toString()) ?? 1,
      sobrevivencia: map['sobrevivencia'] is int
          ? map['sobrevivencia']
          : int.tryParse(map['sobrevivencia'].toString()) ?? 1,
      intimidacao: map['intimidacao'] is int
          ? map['intimidacao']
          : int.tryParse(map['intimidacao'].toString()) ?? 1,
      tecnologia: map['tecnologia'] is int
          ? map['tecnologia']
          : int.tryParse(map['tecnologia'].toString()) ?? 1,
      intuicao: map['intuicao'] is int
          ? map['intuicao']
          : int.tryParse(map['intuicao'].toString()) ?? 1,
      vontade: map['vontade'] is int
          ? map['vontade']
          : int.tryParse(map['vontade'].toString()) ?? 1,
      anotacoes: map['anotacoes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': 'gaia',
      'nome': nome,
      'legado': legado,
      'nivel': nivel,
      'vida': vida,
      'pe': pe,
      'movimentacao': movimentacao,
      'bloqueio': bloqueio,
      'precisao': precisao,
      'brutalidade': brutalidade,
      'destreza': destreza,
      'agilidade': agilidade,
      'canalizacao': canalizacao,
      'arcanismo': arcanismo,
      'espirito': espirito,
      'vigor': vigor,
      'carisma': carisma,
      'medicina': medicina,
      'conhecimentosMisticos': conhecimentosMisticos,
      'percepcao': percepcao,
      'exploracao': exploracao,
      'performance': performance,
      'furtividade': furtividade,
      'religiao': religiao,
      'historia': historia,
      'sobrevivencia': sobrevivencia,
      'intimidacao': intimidacao,
      'tecnologia': tecnologia,
      'intuicao': intuicao,
      'vontade': vontade,
      'anotacoes': anotacoes,
    };
  }
}