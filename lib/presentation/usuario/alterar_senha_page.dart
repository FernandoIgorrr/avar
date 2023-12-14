import 'package:avar/core/app_export.dart';
import 'package:avar/domain/usuario.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AlterarSenhaPage extends StatefulWidget {
  const AlterarSenhaPage({Key? key}) : super(key: key);

  @override
  State<AlterarSenhaPage> createState() => AlterarSenhaPageState();
}

class AlterarSenhaPageState extends State<AlterarSenhaPage> {
  TextEditingController _senhaAntigaController = TextEditingController();
  TextEditingController _senhaNovaController1 = TextEditingController();
  TextEditingController _senhaNovaController2 = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _verSenhaAntiga = true;
  bool _verSenhaNova1 = true;
  bool _verSenhaNova2 = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          automaticallyImplyLeading: false,
          title: AppbarTitle(text: "lbl_alterar_senha".tr),
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
                            "lbl_senha_antiga".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildSenhaAntiga(context, _senhaAntigaController),
                          SizedBox(height: 14.v),
                          Text(
                            "lbl_nova_senha".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildSenhaNova(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_repita_nova_senha".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildRepitaSenhaNova(context),
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
  Widget _buildSenhaAntiga(
      BuildContext context, TextEditingController controller) {
    return CustomTextFormField(
      controller: controller,
      textInputType: TextInputType.text,
      hintText: "lbl_senha_antiga".tr,
      textInputAction: TextInputAction.done,
      obscureText: _verSenhaAntiga,
      suffix: IconButton(
        icon: Icon(_verSenhaAntiga
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined),
        onPressed: () {
          setState(() {
            _verSenhaAntiga = !_verSenhaAntiga;
          });
        },
      ),
      validator: (senha) {
        if (senha == null || senha.isEmpty) {
          return 'Senha Vazia!';
        }
        if (senha.length < 8) {
          return 'A senha de ter no mínimo 8 caracteres!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildSenhaNova(BuildContext context) {
    return CustomTextFormField(
      controller: _senhaNovaController1,
      textInputType: TextInputType.text,
      hintText: "lbl_nova_senha".tr,
      textInputAction: TextInputAction.done,
      obscureText: _verSenhaNova1,
      suffix: IconButton(
        icon: Icon(_verSenhaNova1
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined),
        onPressed: () {
          setState(() {
            _verSenhaNova1 = !_verSenhaNova1;
          });
        },
      ),
      validator: (senha) {
        if (senha == null || senha.isEmpty) {
          return 'Senha Vazia!';
        }
        if (senha.length < 8) {
          return 'A senha de ter no mínimo 8 caracteres!';
        }
        if (_senhaNovaController1.text != _senhaNovaController2.text) {
          return 'As senhas estão diferentes';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildRepitaSenhaNova(BuildContext context) {
    return CustomTextFormField(
      controller: _senhaNovaController2,
      textInputType: TextInputType.text,
      hintText: "lbl_nova_senha".tr,
      textInputAction: TextInputAction.done,
      obscureText: _verSenhaNova2,
      suffix: IconButton(
        icon: Icon(_verSenhaNova2
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined),
        onPressed: () {
          setState(() {
            _verSenhaNova2 = !_verSenhaNova2;
          });
        },
      ),
      validator: (senha) {
        if (senha == null || senha.isEmpty) {
          return 'Senha Vazia!';
        }
        if (senha.length < 8) {
          return 'A senha de ter no mínimo 8 caracteres!';
        }
        if (_senhaNovaController1.text != _senhaNovaController2.text) {
          return 'As senhas estão diferentes';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
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
      String? id = await Usuario.recuperarID();
      UsuarioTrocaSenha user = UsuarioTrocaSenha(
          id: id!,
          senhaAntiga: _senhaAntigaController.text,
          senhaNova: _senhaNovaController1.text);

      try {
        var response = await user.putHttp(
            user.montaURL(URIsAPI.uri_alterar_senha, null), user);

        if (response.statusCode == 200) {
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
            duration: const Duration(seconds: 3),
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
