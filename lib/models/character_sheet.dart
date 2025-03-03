
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

///função auxiliar para fazer a conversão
int parseInt(dynamic value, {int defaultValue = 1}) {
  if (value is int) return value;
  if (value is String) return int.tryParse(value) ?? defaultValue;
  return defaultValue;
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
      nivel: parseInt(map['nivel'], defaultValue: 1), 
      forca: parseInt(map['forca'], defaultValue: 1) ,
      destreza: parseInt(map['destreza'], defaultValue: 1) ,
      constituicao: parseInt(map['constituicao'], defaultValue: 1) ,
      inteligencia: parseInt(map['inteligencia'], defaultValue: 1 ) ,
      sabedoria: parseInt(map['sabedoria'], defaultValue: 1 ) ,
      carisma: parseInt(map['carisma'], defaultValue: 1 ),
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
  final List<String> legados = ['ALRAUNES', 'ELFOS', 'MINOTAUROS', 'NETUNES', 'ANÕES', 'DAEVAS', 'URSARS', 'VALDRAKS', 'HUMANOS', 'DELAHKS', 'DRAENUNS', 'KITARIS', 'ORKRASHS', 'INARIS', 'SEIKOS', 'YUANSUS', 'ZAOKANS', 'ELEMENTAIS', 'FORJADOS', 'KAHATSZAS', 'VENNÉLIS'];
} 

class Habilidades {
  List<String> habilidades = [
    // Habilidades do Andarilho
    "Companheiro Feral",
    "Descendente dos Filhos da Floresta",
    "Perturbação Lúgubre",
    "Forças do Ciclo",
    "Enfeitiçar",
    "Grilhões Primais",
    "Explorador de Auroria",
    "Invólucro Cinzento",
    "Decreto Lunar",
    "Técnica Musical",

    // Habilidades do Combatente
    "Adrenalina",
    "Discípulo do Corpo e Mente",
    "Encantamentos Rúnicos",
    "Ensinamentos do Templo Cinzento",
    "Perito com Armamentos Corpo a Corpo",
    "Perseguidor do Véu",
    "Punição Escarlate",
    "Técnicas Marciais",
    "Calor da Batalha",
    "Perito com Equipamentos Defensivos",

    // Habilidades do Devoto
    "Poder Abissal",
    "Lampejo Celestial",
    "Barreira Protetora",
    "Aspecto da Grandeza",
    "Benção Radiante",
    "Centelha de Édona",
    "Revitalizar",
    "Elo Espiritual",
    "Presente do Abismo",
    "Presente de Édona",

    // Habilidades do Feiticeiro
    "Esfera Espiral Soberana",
    "Explosão de Sangue",
    "Moldar Elemento",
    "Campo Elemental",
    "Perito com Armamentos Mágicos",
    "Rituais Sangrentos",
    "Feitiçaria",
    "Manipular a Fenda",
    "TOQUE DO VÉU",
    "VELOCIDADE MÍSTICA",

    // Habilidades do Ladino
    "ARMADILHAS MÍSTICAS",
    "DISPARO DEBILITANTE",
    "EMBOSCAR",
    "ESTILO ÚNICO",
    "REVIDAR",
    "LADINAGEM",
    "MANTO DAS SOMBRAS",
    "PERITO COM ARMAMENTOS À DISTÂNCIA",
    "REFLEXO ENGANADOR",
    "MARCA SOMBRIA",
  ];

}

class CharacterSheetGaia extends CharacterSheetUniveresal {
  final String legado, habilidade1, habilidade2, habilidade3, habilidade4, habilidade5, habilidade6;
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
    required this.habilidade1,
    required this.habilidade2,
    required this.habilidade3,
    required this.habilidade4,
    required this.habilidade5,
    required this.habilidade6,
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
      habilidade1: map['habilidade1'] ?? '',
      habilidade2: map['habilidade2'] ?? '',
      habilidade3: map['habilidade3'] ?? '',
      habilidade4: map['habilidade4'] ?? '',
      habilidade5: map['habilidade5'] ?? '',
      habilidade6: map['habilidade6'] ?? '',
      nivel: parseInt(map['nivel'], defaultValue: 0),
      vida: parseInt(map['vida'], defaultValue: 0),
      pe: parseInt(map['pe'], defaultValue: 0),
      movimentacao: parseInt(map['movimentacao'], defaultValue: 0),
      bloqueio: parseInt(map['bloqueio'], defaultValue: 0),
      precisao: parseInt(map['precisao'], defaultValue: 0),
      brutalidade: parseInt(map['brutalidade'], defaultValue: 0),
      destreza: parseInt(map['destreza'], defaultValue: 0),
      agilidade: parseInt(map['agilidade'], defaultValue: 0),
      canalizacao: parseInt(map['canalizacao'], defaultValue: 0),
      arcanismo: parseInt(map['arcanismo'], defaultValue: 0),
      espirito: parseInt(map['espirito'], defaultValue: 0),
      vigor: parseInt(map['vigor'], defaultValue: 0),
      carisma: parseInt(map['carisma'], defaultValue: 0),
      medicina: parseInt(map['medicina'], defaultValue: 0),
      conhecimentosMisticos: parseInt(map['conhecimentosMisticos'], defaultValue: 0),
      percepcao: parseInt(map['percepcao'], defaultValue: 0),
      exploracao: parseInt(map['exploracao'], defaultValue: 0),
      performance: parseInt(map['performance'], defaultValue: 0),
      furtividade: parseInt(map['furtividade'], defaultValue: 0),
      religiao: parseInt(map['religiao'], defaultValue: 0),
      historia: parseInt(map['historia'], defaultValue: 0),
      sobrevivencia: parseInt(map['sobrevivencia'], defaultValue: 0),
      intimidacao: parseInt(map['intimidacao'], defaultValue: 0),
      tecnologia: parseInt(map['tecnologia'], defaultValue: 0),
      intuicao: parseInt(map['intuicao'], defaultValue: 0),
      vontade: parseInt(map['vontade'], defaultValue: 0),
      anotacoes: map['anotacoes'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': 'gaia',
      'nome': nome,
      'legado': legado,
      'habilidade1': habilidade1,
      'habilidade2': habilidade2,
      'habilidade3': habilidade3,
      'habilidade4': habilidade4,
      'habilidade5': habilidade5,
      'habilidade6': habilidade6,
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