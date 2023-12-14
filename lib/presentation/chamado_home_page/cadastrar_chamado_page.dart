import 'package:avar/core/app_export.dart';
import 'package:avar/domain/chamado.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:avar/domain/usuario.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class CadastrarChamadoPage extends StatefulWidget {
  const CadastrarChamadoPage({Key? key}) : super(key: key);

  @override
  State<CadastrarChamadoPage> createState() => CadastrarChamadoPageState();
}

class CadastrarChamadoPageState extends State<CadastrarChamadoPage> {
  TextEditingController _tituloController = TextEditingController();

  TextEditingController _descricaoController = TextEditingController();

  TextEditingController _tipoController = TextEditingController();

  TextEditingController _complexoController = TextEditingController();

  TextEditingController _predioController = TextEditingController();

  TextEditingController _andarController = TextEditingController();

  TextEditingController _comodoController = TextEditingController();

  ValueNotifier<int> _reloadPredios = ValueNotifier<int>(1);

  ValueNotifier<int> _reloadAndares = ValueNotifier<int>(1);

  ValueNotifier<int> _reloadComodos = ValueNotifier<int>(1);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TipoChamado tipo;

  @override
  void initState() {
    super.initState();

    tipo = TipoChamado();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_cadastrar_chamado".tr),
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
                            "lbl_titulo".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildTitulo(context),
                          SizedBox(height: 14.v),
                          Text(
                            "lbl_descricao".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 10.v),
                          _buildDescricao(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_tipo".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildTipos(context),
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
  Widget _buildTitulo(BuildContext context) {
    return CustomTextFormField(
      controller: _tituloController,
      textInputType: TextInputType.number,
      validator: (titulo) {
        if (titulo == null || titulo.isEmpty) {
          return 'Título vazio!';
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

  Future<Widget> _buildTipos(BuildContext context) async {
    List<Map<String, dynamic>> items = await tipo.listarTipos();
    return CustomDropDownMenu(
      selectedItemIdController: _tipoController,
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
      String? userId = await Usuario.recuperarID();
      ChamadoCadastrar chamadoCadastrar = ChamadoCadastrar(
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        criador: userId,
        dataAbertura: DateTime.now(),
        localidade: int.parse(_comodoController.text),
        tipo: int.parse(_tipoController.text),
      );

      try {
        var response = await chamadoCadastrar.postHttp(
            chamadoCadastrar.montaURL(URIsAPI.uri_cadastrar_chamado, null),
            chamadoCadastrar);

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
