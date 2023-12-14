import 'package:avar/core/app_export.dart';
import 'package:avar/domain/computador.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class CadastrarComputadorPage extends StatefulWidget {
  const CadastrarComputadorPage({Key? key}) : super(key: key);

  @override
  State<CadastrarComputadorPage> createState() =>
      CadastrarComputadorPageState();
}

class CadastrarComputadorPageState extends State<CadastrarComputadorPage> {
  TextEditingController _tombamentoController = TextEditingController();

  TextEditingController _descricaoController = TextEditingController();

  TextEditingController _estadoController = TextEditingController();

  TextEditingController _serialController = TextEditingController();

  TextEditingController _modeloController = TextEditingController();

  TextEditingController _sistemaOperacionalController = TextEditingController();

  TextEditingController _ramController = TextEditingController();

  TextEditingController _ramddrController = TextEditingController();

  TextEditingController _hdController = TextEditingController();

  TextEditingController _complexoController = TextEditingController();

  TextEditingController _predioController = TextEditingController();

  TextEditingController _andarController = TextEditingController();

  TextEditingController _comodoController = TextEditingController();

  ValueNotifier<int> _reloadPredios = ValueNotifier<int>(1);

  ValueNotifier<int> _reloadAndares = ValueNotifier<int>(1);

  ValueNotifier<int> _reloadComodos = ValueNotifier<int>(1);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_cadastrar_computador".tr),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.v),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "lbl_tombamento".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildTombamento(context),
                          SizedBox(height: 14.v),
                          Text(
                            "lbl_descricao".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildDescricao(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_estado".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildEstados(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LinearProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Erro: ${snapshot.error}');
                              } else {
                                return snapshot.data ?? const SizedBox();
                              }
                            },
                          ),
                          SizedBox(height: 14.v),
                          Text(
                            "lbl_serial".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildSerial(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_modelo".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildModelos(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LinearProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Erro: ${snapshot.error}');
                              } else {
                                return snapshot.data ?? const SizedBox();
                              }
                            },
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_sistema_operacional".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildSistemasOperacionais(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LinearProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Erro: ${snapshot.error}');
                              } else {
                                return snapshot.data ?? const SizedBox();
                              }
                            },
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_ram".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildRAM(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LinearProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Erro: ${snapshot.error}');
                              } else {
                                return snapshot.data ?? const SizedBox();
                              }
                            },
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_ram_ddr".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildRAMDDR(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LinearProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Erro: ${snapshot.error}');
                              } else {
                                return snapshot.data ?? const SizedBox();
                              }
                            },
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_hd".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildHD(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LinearProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Erro: ${snapshot.error}');
                              } else {
                                return snapshot.data ?? const SizedBox();
                              }
                            },
                          ),
                          SizedBox(height: 12.v),
                          SizedBox(
                            width: double.maxFinite,
                            height: 2,
                            child: Container(color: appTheme.blueGray100),
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_localidade".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          SizedBox(
                            width: double.maxFinite,
                            height: 2,
                            child: Container(color: appTheme.blueGray100),
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_complexo".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildComplexo(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LinearProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Erro: ${snapshot.error}');
                              } else {
                                return snapshot.data ?? const SizedBox();
                              }
                            },
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_predio".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          ValueListenableBuilder<int>(
                            valueListenable: _reloadPredios,
                            builder: (context, value, child) {
                              return FutureBuilder(
                                future: _buildPredio(context, value),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const LinearProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Erro: ${snapshot.error}');
                                  } else {
                                    return snapshot.data ?? const SizedBox();
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_andar".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          ValueListenableBuilder<int>(
                            valueListenable: _reloadAndares,
                            builder: (context, value, child) {
                              return FutureBuilder(
                                future: _buildAndar(context, value),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const LinearProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Erro: ${snapshot.error}');
                                  } else {
                                    return snapshot.data ?? const SizedBox();
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_comodo".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          ValueListenableBuilder<int>(
                            valueListenable: _reloadComodos,
                            builder: (context, value, child) {
                              return FutureBuilder(
                                future: _buildComodo(context, value),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const LinearProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Erro: ${snapshot.error}');
                                  } else {
                                    return snapshot.data ?? const SizedBox();
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 30.v),
                          _buildCadastrar(context),
                          SizedBox(height: 50.v),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  /// Section Widget
  Widget _buildTombamento(BuildContext context) {
    return CustomTextFormField(
      controller: _tombamentoController,
      textInputType: TextInputType.number,
      validator: (tombamento) {
        if (tombamento == null || tombamento.isEmpty) {
          return 'Tombamento vazio!';
        } else if (!RegExp(r'^[0-9]+$').hasMatch(_tombamentoController.text)) {
          return 'O tombamento aceita apenas números!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildDescricao(BuildContext context) {
    return CustomTextFormField(
      controller: _descricaoController,
      maxLines: 3,
      validator: (descricao) {
        if (descricao == null || descricao.isEmpty) {
          return 'Descrição vazia!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildSerial(BuildContext context) {
    return CustomTextFormField(
      controller: _serialController,
      maxLines: 1,
      validator: (serial) {
        if (serial == null || serial.isEmpty) {
          return 'Serial vazio!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
    );
  }

  /// Section Widget
  Future<Widget> _buildEstados(BuildContext context) async {
    List<Map<String, dynamic>> items = await listarEstadosPatrimonio();
    return CustomDropDownMenu(
      selectedItemIdController: _estadoController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildModelos(BuildContext context) async {
    List<Map<String, dynamic>> items = await listarModelosPC();
    return CustomDropDownMenu(
      selectedItemIdController: _modeloController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildSistemasOperacionais(BuildContext context) async {
    List<Map<String, dynamic>> items = await listarSistemasOperacionaisPC();
    return CustomDropDownMenu(
      selectedItemIdController: _sistemaOperacionalController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildRAM(BuildContext context) async {
    List<Map<String, dynamic>> items = await listarRAMPC();
    return CustomDropDownMenu(
      selectedItemIdController: _ramController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildRAMDDR(BuildContext context) async {
    List<Map<String, dynamic>> items = await listarRAMDDRPC();
    return CustomDropDownMenu(
      selectedItemIdController: _ramddrController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildHD(BuildContext context) async {
    List<Map<String, dynamic>> items = await listarHD();
    return CustomDropDownMenu(
      selectedItemIdController: _hdController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildComplexo(BuildContext context) async {
    List<Map<String, dynamic>> items = await listarComplexos();
    return CustomDropDownMenu(
      reloadElement: _reloadPredios,
      descName: 'nome',
      selectedItemIdController: _complexoController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildPredio(BuildContext context, int value) async {
    List<Map<String, dynamic>> items;
    items = await listarPredios(value);
    _reloadAndares.value = items.first['id'];
    return CustomDropDownMenu(
      reloadElement: _reloadAndares,
      descName: 'nome',
      selectedItemIdController: _predioController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildAndar(BuildContext context, int value) async {
    List<Map<String, dynamic>> items;
    items = await listarAndares(value);
    _reloadComodos.value = items.first['id'];
    return CustomDropDownMenu(
      reloadElement: _reloadComodos,
      descName: 'nome',
      selectedItemIdController: _andarController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildComodo(BuildContext context, int value) async {
    List<Map<String, dynamic>> items;
    items = await listarComodos(value);
    if (items.isEmpty) {
      return CustomDropDownMenu(
        descName: 'nome',
        selectedItemIdController: _comodoController,
        items: items,
      );
    }
    return CustomDropDownMenu(
      descName: 'nome',
      selectedItemIdController: _comodoController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Widget _buildCadastrar(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_cadastrar".tr,
        margin: EdgeInsets.only(
          left: 15.h,
          right: 15.h,
        ),
        alignment: Alignment.centerRight,
        onPressed: () {
          cadastrar();
        });
  }

  Future<List<Map<String, dynamic>>> listarEstadosPatrimonio() async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      //if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      var url = Uri.parse(URIsAPI.uri_estados_patrimono);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List estadosPatrimonio0 = jsonDecode(utf8.decode(response.bodyBytes));

        var estadosPatrimonio = estadosPatrimonio0
            .map((json) => EstadoPatrimonio.fromJson(json))
            .toList();
        return EstadoPatrimonio.convertListToMapList(estadosPatrimonio);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<List<Map<String, dynamic>>> listarModelosPC() async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      var url = Uri.parse(URIsAPI.uri_modelos);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List modelos0 = jsonDecode(utf8.decode(response.bodyBytes));

        var modelos = modelos0.map((json) => Modelo.fromJson(json)).toList();
        return Modelo.convertListToMapList(modelos);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<List<Map<String, dynamic>>> listarSistemasOperacionaisPC() async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      var url = Uri.parse(URIsAPI.uri_sistemas_operacionais);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List sistemasOperacionais0 =
            jsonDecode(utf8.decode(response.bodyBytes));

        var sistemasOperacionais = sistemasOperacionais0
            .map((json) => SistemaOperacional.fromJson(json))
            .toList();
        return SistemaOperacional.convertListToMapList(sistemasOperacionais);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<List<Map<String, dynamic>>> listarRAMPC() async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      var url = Uri.parse(URIsAPI.uri_ram);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List rams0 = jsonDecode(utf8.decode(response.bodyBytes));

        var rams = rams0.map((json) => RAM.fromJson(json)).toList();
        return RAM.convertListToMapList(rams);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<List<Map<String, dynamic>>> listarRAMDDRPC() async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      var url = Uri.parse(URIsAPI.uri_ram_ddr);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List ramsddr0 = jsonDecode(utf8.decode(response.bodyBytes));

        var ramsddr = ramsddr0.map((json) => RAMDDR.fromJson(json)).toList();
        return RAMDDR.convertListToMapList(ramsddr);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<List<Map<String, dynamic>>> listarHD() async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      var url = Uri.parse(URIsAPI.uri_hd);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List hds0 = jsonDecode(utf8.decode(response.bodyBytes));

        var hds = hds0.map((json) => HD.fromJson(json)).toList();
        return HD.convertListToMapList(hds);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<List<Map<String, dynamic>>> listarComplexos() async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      var url = Uri.parse(URIsAPI.uri_complexos);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List complexos0 = jsonDecode(utf8.decode(response.bodyBytes));

        var complexos =
            complexos0.map((json) => Complexo.fromJson(json)).toList();
        return Complexo.convertListToMapList(complexos);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<List<Map<String, dynamic>>> listarPredios(int complexo) async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      final params = {'complexo': '$complexo'};
      var url = Uri.parse(
        URIsAPI.uri_predios,
      );
      final urlWithParams = Uri.http(url.authority, url.path, params);
      var response = await http.get(urlWithParams, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List predios0 = jsonDecode(utf8.decode(response.bodyBytes));

        var predios = predios0.map((json) => Predio.fromJson(json)).toList();
        return Predio.convertListToMapList(predios);
      } else {
        throw Exception();
      }
    }
  }

  Future<List<Map<String, dynamic>>> listarAndares(int predio) async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      final params = {'predio': '$predio'};
      var url = Uri.parse(
        URIsAPI.uri_andares,
      );
      final urlWithParams = Uri.http(url.authority, url.path, params);
      var response = await http.get(urlWithParams, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List andares0 = jsonDecode(utf8.decode(response.bodyBytes));

        var andares = andares0.map((json) => Andar.fromJson(json)).toList();
        return Andar.convertListToMapList(andares);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<List<Map<String, dynamic>>> listarComodos(int andar) async {
    String? token = await recuperarToken();
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      final params = {'andar': '$andar'};
      var url = Uri.parse(
        URIsAPI.uri_comodos,
      );
      final urlWithParams = Uri.http(url.authority, url.path, params);
      var response = await http.get(urlWithParams, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List comodos0 = jsonDecode(utf8.decode(response.bodyBytes));

        var comodos = comodos0.map((json) => Comodo.fromJson(json)).toList();
        return Comodo.convertListToMapList(comodos);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<String?> recuperarToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  cadastrar() async {
    if (_formKey.currentState!.validate()) {
      ComputadorCadastrar computador = ComputadorCadastrar(
          tombamento: _tombamentoController.text,
          descricao: _descricaoController.text,
          estado: int.parse(_estadoController.text),
          serial: _serialController.text,
          modelo: int.parse(_modeloController.text),
          sistemaOperacional: int.parse(_sistemaOperacionalController.text),
          ram: int.parse(_ramController.text),
          ramDdr: int.parse(_ramddrController.text),
          hd: int.parse(_hdController.text),
          localidade: int.parse(_comodoController.text),
          alienado: false);

      String? token = await recuperarToken();
      if (token == '' || token == null || token.isEmpty) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
        ));
      } else {
        var url = Uri.parse(URIsAPI.uri_cadastrar_computador);

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'Authorization': token,
        };

        String body = jsonEncode(computador.toJson());

        try {
          final response = await http.post(
            url,
            headers: headers,
            body: body,
          );

          if (response.statusCode == 201) {
            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.greenAccent,
              content: Text(response.body,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: appTheme.black900)),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.up,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 210,
                  left: 15,
                  right: 15),
              duration: const Duration(seconds: 2),
            ));
          } else {
            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(response.body, textAlign: TextAlign.center),
              behavior: SnackBarBehavior.floating,
              dismissDirection: DismissDirection.up,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height - 210,
                  left: 15,
                  right: 15),
              duration: const Duration(seconds: 2),
            ));
          }
        } catch (e) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("msg_erro_de_rede".tr, textAlign: TextAlign.center),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.up,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 210,
                left: 15,
                right: 15),
            duration: const Duration(seconds: 2),
          ));
        }
      }
    }
  }
}
