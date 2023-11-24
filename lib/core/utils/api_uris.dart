class URIsAPI {
  // Login
  static const String uri_login = "http://10.0.2.2:8080/api/auth/login";
  // Patrimonios
  static const String uri_listar_patrimonios_tudo =
      "http://10.0.2.2:8080/api/patrimonio/listar";

  static const String uri_estados_patrimono =
      "http://10.0.2.2:8080/api/patrimonio/estado/listar";
  static const String uri_tipos_patrimono =
      "http://10.0.2.2:8080/api/patrimonio/tipo/listar";

  //LOCALIDADES
  static const String uri_complexos =
      "http://10.0.2.2:8080/api/localidade/complexo/listar";
  static const String uri_predios =
      "http://10.0.2.2:8080/api/localidade/predio/listar";
  static const String uri_andares =
      "http://10.0.2.2:8080/api/localidade/andar/listar";
  static const String uri_comodos =
      "http://10.0.2.2:8080/api/localidade/comodo/listar";

  static const String uri_cadastrar_patrimonio =
      "http://10.0.2.2:8080/api/patrimonio/cadastrar";
}
