class URIsAPI {
  // Login
  static const String uri_login = "http://10.0.2.2:8080/api/auth/login";
  static const String uri_dados_usuarios =
      "http://10.0.2.2:8080/api/usuario/usuario_dados";
  static const String uri_alterar_senha =
      "http://10.0.2.2:8080/api/usuario/alterar_senha";

  // Bolsista
  static const String uri_tipos_bolsista =
      "http://10.0.2.2:8080/api/bolsista/tipo/listar";
  static const String uri_cadastrar_bolsista =
      "http://10.0.2.2:8080/api/bolsista/cadastrar";
  static const String uri_listar_bolsistas_tudo =
      "http://10.0.2.2:8080/api/bolsista/listar";
  static const String uri_alterar_dados_bolsista =
      "http://10.0.2.2:8080/api/bolsista/bolsista/atualizar";

  // Patrimonios
  static const String uri_get_patrimonio =
      "http://10.0.2.2:8080/api/patrimonio/get_patrimonio";
  static const String uri_listar_patrimonios_tudo =
      "http://10.0.2.2:8080/api/patrimonio/listar";

  static const String uri_listar_patrimonios_por_tipo =
      "http://10.0.2.2:8080/api/patrimonio/listar_por_tipo";

  static const String uri_listar_patrimonios_por_complexo =
      "http://10.0.2.2:8080/api/patrimonio/listar_por_complexo";

  static const String uri_listar_patrimonios_por_predio =
      "http://10.0.2.2:8080/api/patrimonio/listar_por_predio";

  static const String uri_listar_patrimonios_por_andar =
      "http://10.0.2.2:8080/api/patrimonio/listar_por_andar";

  static const String uri_listar_patrimonios_por_comodo =
      "http://10.0.2.2:8080/api/patrimonio/listar_por_comodo";

  static const String uri_listar_computadores_tudo =
      "http://10.0.2.2:8080/api/patrimonio/computador/listar";

  static const String uri_estados_patrimono =
      "http://10.0.2.2:8080/api/patrimonio/estado/listar";
  static const String uri_tipos_patrimono =
      "http://10.0.2.2:8080/api/patrimonio/tipo/listar";
  static const String Uri_alterar_dados_patrimonio =
      "http://10.0.2.2:8080/api/patrimonio/atualizar";

  static const String uri_cadastrar_manejo =
      "http://10.0.2.2:8080/api/patrimonio/manejar";

  static const String uri_alienar =
      "http://10.0.2.2:8080/api/patrimonio/alienar";

  static const String uri_listar_manejos_tudo =
      "http://10.0.2.2:8080/api/manejo/listar";

  static const String uri_listar_alienamentos_tudo =
      "http://10.0.2.2:8080/api/patrimonio/alienar/listar";

// COMPUTADORES

  static const String uri_listar_computadores_por_complexo =
      "http://10.0.2.2:8080/api/patrimonio/computador/listar_por_complexo";

  static const String uri_listar_computadores_por_predio =
      "http://10.0.2.2:8080/api/patrimonio/computador/listar_por_predio";

  static const String uri_listar_computadoress_por_andar =
      "http://10.0.2.2:8080/api/patrimonio/computador/listar_por_andar";

  static const String uri_alterar_dados_computador =
      "http://10.0.2.2:8080/api/patrimonio/computador/atualizar";

//SPECS PCS
  static const String uri_modelos =
      "http://10.0.2.2:8080/api/pc_specs/modelo/listar";
  static const String uri_sistemas_operacionais =
      "http://10.0.2.2:8080/api/pc_specs/sistema_operacional/listar";
  static const String uri_ram = "http://10.0.2.2:8080/api/pc_specs/ram/listar";
  static const String uri_ram_ddr =
      "http://10.0.2.2:8080/api/pc_specs/ram_ddr/listar";
  static const String uri_hd = "http://10.0.2.2:8080/api/pc_specs/hd/listar";

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

  static const String uri_cadastrar_computador =
      "http://10.0.2.2:8080/api/patrimonio/computador/cadastrar";

  // CHAMADOS

  static const String uri_fechar_chamados =
      "http://10.0.2.2:8080/api/chamado/fechar";
  static const String uri_alterar_chamados =
      "http://10.0.2.2:8080/api/chamado/alterar";

  static const String uri_listar_chamados_tudo =
      "http://10.0.2.2:8080/api/chamado/listar";
  static const String uri_listar_chamados_por_estado =
      "http://10.0.2.2:8080/api/chamado/listar_por_estado";
  static const String uri_cadastrar_chamado =
      "http://10.0.2.2:8080/api/chamado/cadastrar";
  static const String uri_estados_chamado =
      "http://10.0.2.2:8080/api/chamado/estado/listar";
  static const String uri_tipos_chamado =
      "http://10.0.2.2:8080/api/chamado/tipo/listar";
}
