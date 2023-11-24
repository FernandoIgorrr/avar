class Complexo {
  int? id;
  String? nome;

  Complexo({this.id, this.nome});

  Complexo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<Complexo> tipoPatrimonioList) {
    return tipoPatrimonioList
        .map((tipoPatrimonio) => tipoPatrimonio.toJson())
        .toList();
  }
}

class Predio {
  int? id;
  String? nome;
  Complexo? complexo;

  Predio({this.id, this.nome, this.complexo});

  Predio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    complexo =
        json['complexo'] != null ? Complexo.fromJson(json['complexo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    if (complexo != null) {
      data['complexo'] = complexo!.toJson();
    }
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<Predio> tipoPatrimonioList) {
    return tipoPatrimonioList
        .map((tipoPatrimonio) => tipoPatrimonio.toJson())
        .toList();
  }
}

class Andar {
  int? id;
  String? nome;
  Predio? predio;

  Andar({this.id, this.nome, this.predio});

  Andar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    predio = json['predio'] != null ? Predio.fromJson(json['predio']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    if (predio != null) {
      data['predio'] = predio!.toJson();
    }
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<Andar> tipoPatrimonioList) {
    return tipoPatrimonioList
        .map((tipoPatrimonio) => tipoPatrimonio.toJson())
        .toList();
  }
}

class Comodo {
  int? id;
  String? nome;
  Andar? andar;

  Comodo({this.id, this.nome, this.andar});

  Comodo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    andar = json['andar'] != null ? Andar.fromJson(json['andar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nome'] = nome;
    if (andar != null) {
      data['andar'] = andar!.toJson();
    }
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<Comodo> tipoPatrimonioList) {
    return tipoPatrimonioList
        .map((tipoPatrimonio) => tipoPatrimonio.toJson())
        .toList();
  }
}
