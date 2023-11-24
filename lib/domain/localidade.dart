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
}
