import 'package:avar/core/app_export.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class CadastrarPatrimonioPage extends StatefulWidget {
  const CadastrarPatrimonioPage({Key? key}) : super(key: key);

  @override
  State<CadastrarPatrimonioPage> createState() =>
      CadastrarPatrimonioPageState();
}

class CadastrarPatrimonioPageState extends State<CadastrarPatrimonioPage> {
  TextEditingController tombamentoController = TextEditingController();

  TextEditingController descricaoController = TextEditingController();

  TextEditingController estadoController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_cadastrar_patrimonio".tr),
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
                        SizedBox(height: 10.v),
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
                        SizedBox(height: 30.v),
                        _buildCadastrar(context),
                        SizedBox(height: 50.v),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }

  /// Section Widget
  Widget _buildTombamento(BuildContext context) {
    return CustomTextFormField(
      controller: tombamentoController,
      textInputType: TextInputType.number,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildDescricao(BuildContext context) {
    return CustomTextFormField(
      controller: descricaoController,
      maxLines: 5,
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
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildTipos(BuildContext context) async {
    List<Map<String, dynamic>> items = await listarTiposPatrimonio();
    return CustomDropDownMenu(
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
    );
  }

  Future<List<Map<String, dynamic>>> listarEstadosPatrimonio() async {
    String? token = await recuperarToken();
    print('Token : $token');
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
        List estadosPatrimonio0 = json.decode(response.body);

        var estadosPatrimonio = estadosPatrimonio0
            .map((json) => EstadoPatrimonio.fromJson(json))
            .toList();
        return EstadoPatrimonio.convertListToMapList(estadosPatrimonio);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<List<Map<String, dynamic>>> listarTiposPatrimonio() async {
    String? token = await recuperarToken();
    print('Token : $token');
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
      var url = Uri.parse(URIsAPI.uri_tipos_patrimono);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });
      if (response.statusCode == 200) {
        List tiposPatrimonio0 = json.decode(response.body);

        var tiposPatrimonio = tiposPatrimonio0
            .map((json) => TipoPatrimonio.fromJson(json))
            .toList();
        return TipoPatrimonio.convertListToMapList(tiposPatrimonio);
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<String?> recuperarToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
