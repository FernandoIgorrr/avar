class PatrimonioListar {
  String? id;
  String? tombamento;
  String? descricao;
  String? estado;
  String? tipo;
  bool? alienado;
  String? comodo;
  String? andar;
  String? predio;
  String? complexo;

  PatrimonioListar(
      {this.id,
      this.tombamento,
      this.descricao,
      this.estado,
      this.tipo,
      this.alienado,
      this.comodo,
      this.andar,
      this.predio,
      this.complexo});

  PatrimonioListar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tombamento = json['tombamento'];
    descricao = json['descricao'];
    estado = json['estado'];
    tipo = json['tipo'];
    alienado = json['alienado'];
    comodo = json['comodo'];
    andar = json['andar'];
    predio = json['predio'];
    complexo = json['complexo'];
  }
}

class PatrimonioCadastrar {
  String? tombamento;
  String? descricao;
  int? estado;
  int? tipo;
  int? localidade;
  bool? alienado;

  PatrimonioCadastrar(
      {this.tombamento,
      this.descricao,
      this.estado,
      this.tipo,
      this.localidade,
      this.alienado});

  PatrimonioCadastrar.fromJson(Map<String, dynamic> json) {
    tombamento = json['tombamento'];
    descricao = json['descricao'];
    estado = json['estado'];
    tipo = json['tipo'];
    localidade = json['localidade'];
    alienado = json['alienado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tombamento'] = this.tombamento;
    data['descricao'] = this.descricao;
    data['estado'] = this.estado;
    data['tipo'] = this.tipo;
    data['localidade'] = this.localidade;
    data['alienado'] = this.alienado;
    return data;
  }
}

class EstadoPatrimonio {
  int? id;
  String? descricao;

  EstadoPatrimonio({this.id, this.descricao});

  EstadoPatrimonio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<EstadoPatrimonio> estadoPatrimonioList) {
    return estadoPatrimonioList
        .map((estadoPatrimonio) => estadoPatrimonio.toJson())
        .toList();
  }
}

class TipoPatrimonio {
  int? id;
  String? descricao;

  TipoPatrimonio({this.id, this.descricao});

  TipoPatrimonio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    return data;
  }

  static List<Map<String, dynamic>> convertListToMapList(
      List<TipoPatrimonio> tipoPatrimonioList) {
    return tipoPatrimonioList
        .map((tipoPatrimonio) => tipoPatrimonio.toJson())
        .toList();
  }
}
