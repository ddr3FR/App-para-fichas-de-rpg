
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
class ListaDeRacas {
  final List<String> listaDeRacas = [
    'Humano',
    'Elfo',
    'Anão',
    'Halfling',
    'Draconato',
    'Gnomo',
    'Meio-Elfo',
    'Meio-Orc',
    'Tiefling',
    'Aasimar',
    'Bugbear',
    'Firbolg',
    'Goblin',
    'Golias',
    'Hobgoblin',
    'Kenku',
    'Kóbolds',
    'Lagarto Folclórico',
    'Orc',
    'Tabaxi',
    'Tortle',
    'Tritão',
    'Yuan-ti Puro Sangue',
    'Genasi (Ar, Água, Fogo, Terra)',
    'Gith (Githyanki, Githzerai)',
    'Aarakocra',
    'Genio',
    'Loxodon',
    'Centauro',
    'Minotauro',
    'Simic Hybrid',
    'Vedalken',
    'Changeling',
    'Kalashtar',
    'Shifter',
    'Forjado',
    'Lobisomem',
    'Vampiro'
  ];
}
class ListaDeClasses {
  final List<String> listaDeClasses = [
        'Bárbaro',
        'Bardo',
        'Bruxo',
        'Clérigo',
        'Druida',
        'Feiticeiro',
        'Guerreiro',
        'Ladino',
        'Mago',
        'Monge',
        'Paladino',
        'Patrulheiro',
        'Artífice',
        'Caçador de Sángue',
        'Cavaleiro do Dração'
      ];
}

class CharacterSheetDeD extends CharacterSheetUniveresal {
  ///Infomações de bases
  final String classe;
  final String raca;
  final String antecedente;
  final String alinhamento;
  final int exp;
  final int cA;
  final int deslocamento;
  final int iniciativa;
  final String tracosDePers;
  final String ideais;
  final String ligacoes;
  final String defeitos;
  ///Infomações de atributo
  final int forca;
  final int destreza;
  final int constituicao;
  final int inteligencia;
  final int sabedoria;
  final int carisma;
  ///Infomações de pericias
  final int bonusDeProef;
  final int inspiracao;
  final int acrobacia;
  final int adestrarAnimais;
  final int arcanismo;
  final int atletismo;
  final int atuacao;
  final int blefar;
  final int enganacao;
  final int furtividade;
  final int historia;
  final int intimidacao;
  final int intuicao;
  final int investigacao;
  final int medicina;
  final int natureza;
  final int percepcao;
  final int persuasao;
  final int prestidigitacao;
  final int religiao;
  final int sobrevivencia;
  CharacterSheetDeD({
    ///Infomações de bases
    required String nome,
    required int nivel,
    required this.classe,
    required this.raca,
    required this.antecedente,
    required this.alinhamento,
    required this.exp,
    required this.cA,
    required this.deslocamento,
    required this.iniciativa,
    required this.tracosDePers,
    required this.ideais,
    required this.ligacoes,
    required this.defeitos,
    required String anotacoes,
    ///Infomações de atributo
    required this.forca,
    required this.destreza,
    required this.constituicao,
    required this.inteligencia,
    required this.sabedoria,
    required this.carisma,
    ///Infomações de pericias
    required this.bonusDeProef,
    required this.inspiracao,
    required this.acrobacia,
    required this.adestrarAnimais,
    required this.arcanismo,
    required this.atletismo,
    required this.atuacao,
    required this.blefar,
    required this.enganacao,
    required this.furtividade,
    required this.historia,
    required this.intimidacao,
    required this.intuicao,
    required this.investigacao,
    required this.medicina,
    required this.natureza,
    required this.percepcao,
    required this.persuasao,
    required this.prestidigitacao,
    required this.religiao,
    required this.sobrevivencia,
  }) : super(nome: nome, anotacoes: anotacoes, nivel: nivel);

  factory CharacterSheetDeD.fromMap(Map<String, dynamic> map) {
    return CharacterSheetDeD(
      ///Infomações de bases
      nome: map['nome'] ?? '',
      classe: map['classe'] ?? '',
      raca: map['raca'] ?? '',
      nivel: parseInt(map['nivel'], defaultValue: 1), 
      exp: parseInt(map['exp'], defaultValue: 1),
      antecedente: map['antecedente']?? '',
      alinhamento: map['alinhamento']?? '',
      cA: parseInt(map['cA'], defaultValue: 1),
      deslocamento: parseInt(map['deslocamento'], defaultValue: 1),
      iniciativa: parseInt(map['iniciativa'], defaultValue: 1),
      tracosDePers: map['tracosDePers'] ?? '',
      ideais: map['ideais'] ?? '',
      ligacoes: map['ligacoes'] ?? '',
      defeitos: map['defeitos'] ?? '',
      anotacoes: map['anotacoes'] ?? '',
      ///Infomações de atributo
      forca: parseInt(map['forca'], defaultValue: 1) ,
      destreza: parseInt(map['destreza'], defaultValue: 1) ,
      constituicao: parseInt(map['constituicao'], defaultValue: 1) ,
      inteligencia: parseInt(map['inteligencia'], defaultValue: 1 ) ,
      sabedoria: parseInt(map['sabedoria'], defaultValue: 1 ) ,
      carisma: parseInt(map['carisma'], defaultValue: 1 ),
      ///Infomações de pericias
      bonusDeProef: parseInt(map['bonusDeProef'], defaultValue: 1),
      inspiracao: parseInt(map['inspiracao'], defaultValue: 1),
      acrobacia: parseInt(map['acrobacia'], defaultValue: 1),
      adestrarAnimais: parseInt(map['adestrarAnimais'], defaultValue: 1),
      arcanismo: parseInt(map['arcanismo'], defaultValue: 1),
      atletismo: parseInt(map['atletismo'], defaultValue: 1),
      atuacao: parseInt(map['atuacao'], defaultValue: 1),
      blefar: parseInt(map['blefar'], defaultValue: 1),
      enganacao: parseInt(map['enganacao'], defaultValue: 1),
      furtividade: parseInt(map['furtividade'], defaultValue: 1),
      historia: parseInt(map['historia'], defaultValue: 1),
      intimidacao: parseInt(map['intimidacao'], defaultValue: 1),
      intuicao: parseInt(map['intuicao'], defaultValue: 1),
      investigacao: parseInt(map['investigacao'], defaultValue: 1),
      medicina: parseInt(map['medicina'], defaultValue: 1),
      natureza: parseInt(map['natureza'], defaultValue: 1),
      percepcao: parseInt(map['percepcao'], defaultValue: 1),
      persuasao: parseInt(map['persuasao'], defaultValue: 1),
      prestidigitacao: parseInt(map['prestidigitacao'], defaultValue: 1),
      religiao: parseInt(map['religiao'], defaultValue: 1),
      sobrevivencia: parseInt(map['sobrevivencia'], defaultValue: 1), 
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ///Infomações de bases
      'type': 'dnd',
      'nome': nome,
      'classe': classe,
      'raca': raca,
      'nivel': nivel,
      'exp' : exp,
      'antecedente' : antecedente,
      'alinhamento' : alinhamento,
      'cA' : cA,
      'deslocamento' : deslocamento,
      'iniciativa' : iniciativa,
      'tracosDePers' : tracosDePers,
      'ideais' : ideais,
      'ligacoes' : ligacoes,
      'defeitos' : defeitos,
      'anotacoes': anotacoes,
      ///Infomações de atributo
      'forca': forca,
      'destreza': destreza,
      'constituicao': constituicao,
      'inteligencia': inteligencia,
      'sabedoria': sabedoria,
      'carisma': carisma,
      ///Infomações de pericias
      'bonusDeProef' : bonusDeProef,
      'inspiracao' : inspiracao,
      'acrobacia': acrobacia,
      'adestrarAnimais': adestrarAnimais,
      'arcanismo': arcanismo,
      'atletismo': atletismo,
      'atuacao': atuacao,
      'blefar': blefar,
      'enganacao' : enganacao,
      'furtividade': furtividade,
      'historia': historia,
      'intimidacao': intimidacao,
      'intuicao': intuicao,
      'investigacao': investigacao,
      'medicina': medicina,
      'natureza': natureza,
      'percepcao': percepcao,
      'persuasao': persuasao,
      'prestidigitacao': prestidigitacao,
      'religiao': religiao,
      'sobrevivencia': sobrevivencia,
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
class Armas{
  List<String> armas = [
    // Armamentos Leves
    'Adagas(Dex)',
    'Maças(Brut)',
    'Machados Leves(Brut)',
    'Espadas Curtas(Dex ou Brut)',

    // Armamentos Pesados
    'Lanças(Brut ou Dex)',
    'Martelos de Guerra(Brut)',
    'Machados Pesados(Brut)',
    'Espadas Longas(Brut ou Dex)',

    // Armamentos à Distância
    'Revólveres(Dex)',
    'Bestas Pequenas(Dex)',
    'Arcos(Dex)',
    'Mosquetes(Dex)',
    'Bestas Grandes(Dex)',

    // Armamentos Mágicos
    'Berloques de Energia(Arca)',
    'Catalisadores Místicos(Arca)',

    // Armamentos Especiais
    'Armas de Punho(-)'
  ];
}
final Map<String, int> weaponBaseDamage = {
  'Adagas(Dex)': 2,
  'Maças(Brut)': 2,
  'Machados Leves(Brut)': 3,
  'Espadas Curtas(Dex ou Brut)': 3,
  'Lanças(Brut ou Dex)': 4,
  'Martelos de Guerra(Brut)': 4,
  'Machados Pesados(Brut)': 5,
  'Espadas Longas(Brut ou Dex)': 5,
  'Revólveres(Dex)' : 3,
  'Bestas Pequenas(Dex)' : 2,
  'Arcos(Dex)' : 4,
  'Mosquetes(Dex)': 6,
  'Bestas Grandes(Dex)': 5,
  'Berloques de Energia(Arca)': 2,
  'Catalisadores Místicos(Arca)': 4,
};

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
  final String arma;
  final int danoArma;
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
    required this.arma,
    required this.danoArma,
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
      arma: map['arma']??'',
      danoArma: parseInt(map['danoArma'], defaultValue: 0),
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
      'arma' : arma,
      'danoArma' : danoArma,
      'anotacoes': anotacoes,
    };
  }
}