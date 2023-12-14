import 'package:avar/core/app_export.dart';
import 'package:avar/domain/usuario.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class EditarBolsistaPage extends StatefulWidget {
  EditarBolsistaPage({Key? key, required this.bolsista}) : super(key: key);

  BolsistaListar bolsista;

  @override
  State<EditarBolsistaPage> createState() => EditarBolsistaPageState();
}

class EditarBolsistaPageState extends State<EditarBolsistaPage> {
  TextEditingController _matriculaController = TextEditingController();

  TextEditingController _nomeController = TextEditingController();

  TextEditingController _loginController = TextEditingController();
  TextEditingController _telefoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  TextEditingController _tipoBolsistaController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TipoBolsista tipo;

  @override
  void initState() {
    super.initState();

    tipo = TipoBolsista();

    _matriculaController.text = widget.bolsista.matricula.toString();
    _nomeController.text = widget.bolsista.nome.toString();
    _loginController.text = widget.bolsista.login.toString();
    _telefoneController.text = widget.bolsista.telefone.toString();
    _emailController.text = widget.bolsista.email.toString();
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
                            "lbl_matricula".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildmatricula(context),
                          SizedBox(height: 14.v),
                          Text(
                            "lbl_nome".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildNome(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_login".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildLogin(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_email".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildEmail(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_telefone".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildTelefone(context),
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
  Widget _buildmatricula(BuildContext context) {
    return CustomTextFormField(
      controller: _matriculaController,
      textInputType: TextInputType.number,
      validator: (matricula) {
        if (matricula == null || matricula.isEmpty) {
          return 'Matricula vazia!';
        } else if (!RegExp(r'^[0-9]+$').hasMatch(_matriculaController.text)) {
          return 'A matricula aceita apenas números!';
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
  Widget _buildNome(BuildContext context) {
    return CustomTextFormField(
      controller: _nomeController,
      validator: (nome) {
        if (nome == null || nome.isEmpty) {
          return 'Nome vazio!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildLogin(BuildContext context) {
    return CustomTextFormField(
      controller: _loginController,
      validator: (login) {
        if (login == null || login.isEmpty) {
          return 'Login vazio!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildTelefone(BuildContext context) {
    return CustomTextFormField(
      controller: _telefoneController,
      textInputType: TextInputType.number,
      validator: (telefone) {
        if (telefone == null || telefone.isEmpty) {
          return 'Telefone vazio!';
        } else if (!RegExp(r'^[0-9]+$').hasMatch(_telefoneController.text)) {
          return 'O telefone aceita apenas números!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: _emailController,
      textInputType: TextInputType.emailAddress,
      validator: (email) {
        if (email == null || email.isEmpty) {
          return 'E-mail vazio!';
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
      selectedItem: widget.bolsista.tipo,
      selectedItemIdController: _tipoBolsistaController,
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
      BolsistaCadastrar bolsista = BolsistaCadastrar(
        id: widget.bolsista.id,
        matricula: _matriculaController.text,
        login: _loginController.text,
        nome: _nomeController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        tipoBolsista: int.parse(_tipoBolsistaController.text),
        dataChegada: DateTime.now(),
      );
      try {
        print(bolsista.toJson());
        var response = await bolsista.putHttp(
            bolsista.montaURL(URIsAPI.uri_alterar_dados_bolsista, null),
            bolsista);

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
          duration: const Duration(seconds: 3),
        ));
      }
    }
  }
}
