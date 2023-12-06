import 'package:avar/domain/usuario.dart';

class URIsAPI {
  // Login
  static const String uri_login = "http://10.0.2.2:8080/api/auth/login";
  // Patrimonios
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
}
