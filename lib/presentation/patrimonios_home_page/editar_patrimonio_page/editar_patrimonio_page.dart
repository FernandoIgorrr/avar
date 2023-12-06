import 'package:avar/core/app_export.dart';
import 'package:avar/domain/computador.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: must_be_immutable
class EditarPatrimonioPage extends StatefulWidget {
  EditarPatrimonioPage({Key? key, required this.patrimonio}) : super(key: key);

  PatrimonioListar patrimonio;

  @override
  State<EditarPatrimonioPage> createState() => EditarPatrimonioPageState();
}

class EditarPatrimonioPageState extends State<EditarPatrimonioPage> {
  TextEditingController _tombamentoController = TextEditingController();

  TextEditingController _descricaoController = TextEditingController();

  TextEditingController _estadoController = TextEditingController();

  TextEditingController _tipoController = TextEditingController();


  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late EstadoPatrimonio estado;

  late TipoPatrimonio tipo;

  @override
  void initState() {
    super.initState();

    estado = EstadoPatrimonio();

    tipo = TipoPatrimonio();

    _tombamentoController.text = widget.patrimonio.tombamento.toString();
    _descricaoController.text = widget.patrimonio.descricao.toString();
  
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_alterar_dados".tr),
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
                          _buildAlterar(context),
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
        bottomNavigationBar: CustomBottomBar(),
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
    List<Map<String, dynamic>> items = await estado.listarEstados();
    return CustomDropDownMenu(
      selectedItem: widget.patrimonio.estado,
      selectedItemIdController: _estadoController,
      items: items,
    );
  }

  Future<Widget> _buildTipos(BuildContext context) async {
    List<Map<String, dynamic>> items = await tipo.listarTipos();
    return CustomDropDownMenu(
      selectedItem: widget.patrimonio.tipo,
      selectedItemIdController: _tipoController,
      items: items,
    );
  }



  Widget _buildAlterar(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_alterar".tr,
        margin: EdgeInsets.only(
          left: 15.h,
          right: 15.h,
        ),
        alignment: Alignment.centerRight,
        onPressed: () {
          alterar();
        });
  }

  alterar() async {
    if (_formKey.currentState!.validate()) {
      patrimonioCadastrar patrimonio = patrimonioCadastrar(
          id: widget.patrimonio.id,
          tombamento: _tombamentoController.text,
          descricao: _descricaoController.text,
          estado: int.parse(_estadoController.text),
          tipo: int.parse(_tipoController.text),
          alienado: false);
      // try {
      var response = await patrimonio.putHttp(
          patrimonio.montaURL(URIsAPI.uri_alterar_dados_patrimonio, null),
          patrimonio);

      if (response.statusCode == 202) {
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
          duration: const Duration(seconds: 5),
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
          duration: const Duration(seconds: 5),
        ));
      }
      // } catch (e) {
      //   if (!mounted) return;

      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //     backgroundColor: Colors.redAccent,
      //     content: Text("msg_erro_de_rede".tr, textAlign: TextAlign.center),
      //     behavior: SnackBarBehavior.floating,
      //     dismissDirection: DismissDirection.up,
      //     margin: EdgeInsets.only(
      //         bottom: MediaQuery.of(context).size.height - 210,
      //         left: 15,
      //         right: 15),
      //     duration: const Duration(seconds: 5),
      //   ));
      // }
    }
  }
}
