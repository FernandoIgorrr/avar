import 'package:avar/core/app_export.dart';
import 'package:avar/domain/chamado.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class EditarChamadoPage extends StatefulWidget {
  EditarChamadoPage({Key? key, required this.chamado}) : super(key: key);

  ChamadoListar chamado;

  @override
  State<EditarChamadoPage> createState() => EditarChamadoPageState();
}

class EditarChamadoPageState extends State<EditarChamadoPage> {
  TextEditingController _tituloController = TextEditingController();

  TextEditingController _descricaoController = TextEditingController();

  TextEditingController _estadoController = TextEditingController();

  TextEditingController _tipoController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late EstadoChamado estado;

  late TipoChamado tipo;

  @override
  void initState() {
    super.initState();

    estado = EstadoChamado();

    tipo = TipoChamado();

    _tituloController.text = widget.chamado.titulo!;
    _descricaoController.text = widget.chamado.descricao!;
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

  Future<Widget> _buildEstados(BuildContext context) async {
    List<Map<String, dynamic>> items = await estado.listarEstados();
    return CustomDropDownMenu(
      selectedItem: widget.chamado.estado,
      selectedItemIdController: _estadoController,
      items: items,
    );
  }

  Future<Widget> _buildTipos(BuildContext context) async {
    List<Map<String, dynamic>> items = await tipo.listarTipos();
    return CustomDropDownMenu(
      selectedItem: widget.chamado.tipo,
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
      ChamadoAlterar chamadoAlterar = ChamadoAlterar(
          id: widget.chamado.id,
          titulo: _tipoController.text,
          descricao: _descricaoController.text,
          estado: int.parse(_estadoController.text),
          tipo: int.parse(_tipoController.text));

      try {
        var response = await chamadoAlterar.putHttp(
            chamadoAlterar.montaURL(URIsAPI.uri_alterar_chamados, null),
            chamadoAlterar);

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
