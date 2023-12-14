import 'package:avar/presentation/bolsista_home_page/bolsista_home_page.dart';
import 'package:avar/presentation/chamado_home_page/cadastrar_chamado_page.dart';
import 'package:avar/presentation/chamado_home_page/chamado_home_page.dart';
import 'package:avar/presentation/chamado_home_page/listar_chamado_tudo_page.dart';
import 'package:avar/presentation/chamado_home_page/listar_chamados_por_estado.dart';
import 'package:avar/presentation/patrimonios_home_page/alienamentos_patrimonio_page/alienamentos_patrimonio_page.dart';
import 'package:avar/presentation/patrimonios_home_page/cadastrar_computador_page/cadastrar_computador_page.dart';
import 'package:avar/presentation/patrimonios_home_page/cadastrar_patrimonio_page/cadastrar_patrimonio_page.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_computadores_page/listar_computadores_page.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_computadores_page/listar_computadores_por_andar.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_computadores_page/listar_computadores_por_complexo.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_computadores_page/listar_computadores_por_predio.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_computadores_page/listar_computadores_tudo.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_patrimonios_page/listar_patrimonios_page.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_patrimonios_page/listar_patrimonios_por_comodo.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_patrimonios_page/listar_patrimonios_por_complexo.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_patrimonios_page/listar_patrimonios_por_predio.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_patrimonios_page/listar_patrimonios_por_tipo.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_patrimonios_page/listar_patrimonios_tudo.dart';
import 'package:avar/presentation/patrimonios_home_page/listar_patrimonios_page/listar_patriomonios_por_andar.dart';
import 'package:avar/presentation/patrimonios_home_page/manejar_patrimonio_page/listar_manejos_tudo.dart';
import 'package:avar/presentation/patrimonios_home_page/patrimonios_home_page.dart';
import 'package:avar/presentation/supervisor_home_page/bolsista_opcoes_page/bolsista_cadastrar_page.dart';
import 'package:avar/presentation/supervisor_home_page/bolsista_opcoes_page/bolsista_listar_page.dart';
import 'package:avar/presentation/supervisor_home_page/bolsista_opcoes_page/bolsista_listar_tudo_page.dart';
import 'package:avar/presentation/supervisor_home_page/bolsista_opcoes_page/bolsista_page.dart';
import 'package:avar/presentation/supervisor_home_page/supervisor_home_page.dart';
import 'package:avar/presentation/load_screen/load_screen.dart';
import 'package:avar/presentation/login_screen/login_screen.dart';
import 'package:avar/presentation/usuario/alterar_senha_page.dart';

import 'package:flutter/material.dart';

class AppRoutes {
  static const String loginScreen = '/login_screen';
  static const String loadScreen = '/load_screen';
  static const String supervisorHomePage = '/supervisor_home_page';
  static const String bolsistaHomePage = '/bolsista_home_page';
  static const String bolsistaPage = '/bolsista_page';
  static const String patrimoniosHomePage = '/patrimonios_home_page';
  static const String chamadoHomePage = '/chamado_home_page';
  static const String listarPatrimoniosHomePage =
      '/listar_patrimonios_home_page';
  static const String listarComputadoresHomePage =
      '/listar_computadores_home_page';
  static const String listarPatrimoniosTudo = 'listar_patrimonios_tudo';
  static const String listarComputadoresTudo = 'listar_computadores_tudo';

  //PATRIMONIOS GERAL
  static const String listarPatrimoniosComplexo = 'listar_patrimonios_complexo';
  static const String listarPatrimoniosTipo = 'listar_patrimonios_tipo';
  static const String listarPatrimoniosAndar = 'listar_patrimonios_andar';
  static const String listarPatrimoniosComodo = 'listar_patrimonios_comodo';
  static const String listarPatrimoniosPredio = 'listar_patrimonios_predio';
  // PCS
  static const String listarComputadoresAndar = 'listar_computadores_andar';
  static const String listarComputadoresComplexo =
      'listar_computadores_complexo';
  static const String listarComputadoresPredio = 'listar_computadores_predio';
  // BOLSISTA
  static const String bolsistaListarPage = 'bolsista_listar_page';
  static const String bolsistaListarTudo = 'listar_bolsista_tudo';
  // CADASTRO
  static const String cadastrarPatrimonio = 'cadastrar_patrimonio';
  static const String cadastrarComputador = 'cadastrar_computador';
  static const String cadastrarBolsista = 'cadastrar_bolsista';
  static const String cadastrarChamado = 'cadastrar_chamdo';

  // MANEJOS
  static const String listarManejosTudo = 'listar_manejos_tudo';

  //ALIENAMENTOS
  static const String listarAlienamentosTudo = 'listar_alienamentos_tudo';
  static const String listarChamadosTudo = 'listar_chamados_tudo';
  static const String listarChamadosPorEstado = 'listar_chamados_por_estado';

  // USUARIO
  static const String alterarSenha = 'alterar_senha';

  static Map<String, WidgetBuilder> routes = {
    loginScreen: (context) => LoginScreen(),
    loadScreen: (context) => LoadScreen(),
    supervisorHomePage: (context) => SupervisorHomePage(),
    bolsistaHomePage: (context) => BolsistaHomePage(),
    patrimoniosHomePage: (context) => PatrimoniosHomePage(),
    chamadoHomePage: (context) => ChamadosHomePage(),
    bolsistaPage: (context) => BolsistaPage(),
    bolsistaListarPage: (context) => BolsistaListarPage(),
    bolsistaListarTudo: (context) => BolsistaListarTudo(),
    listarPatrimoniosHomePage: (context) => ListarPatrimoniosPage(),
    listarComputadoresHomePage: (context) => ListarComputadoresPage(),
    listarPatrimoniosTudo: (context) => ListarPatrimoniosTudo(),
    listarPatrimoniosTipo: (context) => ListarPatrimoniosPorTipo(),
    listarPatrimoniosComplexo: (context) => ListarPatrimoniosPorComplexo(),
    listarPatrimoniosPredio: (context) => ListarPatrimoniosPorPredio(),
    listarPatrimoniosAndar: (context) => ListarPatrimoniosPorAndar(),
    listarPatrimoniosComodo: (context) => ListarPatrimoniosPorComodo(),
    listarComputadoresTudo: (context) => ListarComputadoresTudo(),
    listarComputadoresComplexo: (context) => ListarComputadoresPorComplexo(),
    listarComputadoresPredio: (context) => ListarComputadoresPorPredio(),
    listarComputadoresAndar: (context) => ListarComputadoresPorAndar(),
    cadastrarPatrimonio: (context) => CadastrarPatrimonioPage(),
    cadastrarComputador: (context) => CadastrarComputadorPage(),
    cadastrarBolsista: (context) => CadastrarBolsistaPage(),
    cadastrarChamado: (context) => CadastrarChamadoPage(),
    alterarSenha: (context) => AlterarSenhaPage(),
    listarManejosTudo: (context) => ListarManejosTudo(),
    listarAlienamentosTudo: (context) => ListarAlienamentosTudo(),
    listarChamadosTudo: (context) => ListarChamadosTudo(),
    listarChamadosPorEstado: (context) => ListarChamadosPorEstado(),
  };
}
