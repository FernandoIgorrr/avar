import 'package:avar/domain/usuario.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:avar/core/app_export.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _verSenha = true;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 37.h,
            vertical: 150.v,
          ),
          //child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgLogo2,
                  height: 64.v,
                  width: 222.h,
                ),
                const Spacer(
                  flex: 45,
                ),
                CustomTextFormField(
                  controller: _userNameController,
                  hintText: "lbl_usuario".tr,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 11.h,
                    vertical: 12.v,
                  ),
                ),
                SizedBox(height: 20.v),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: "lbl_senha".tr,
                  textInputAction: TextInputAction.done,
                  obscureText: _verSenha,
                  suffix: IconButton(
                    icon: Icon(_verSenha
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () {
                      setState(() {
                        _verSenha = !_verSenha;
                      });
                    },
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 11.h,
                    vertical: 12.v,
                  ),
                ),
                SizedBox(height: 20.v),
                CustomElevatedButton(
                  text: "lbl_acessar".tr,
                  buttonStyle: CustomButtonStyles.fillPurple,
                  buttonTextStyle: theme.textTheme.headlineSmall!,
                  onPressed: () {
                    logar();
                  },
                ),
                const Spacer(
                  flex: 54,
                ),
              ],
            ),
            //),
          ),
        ),
      ),
    );
  }

  logar() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    try {
      var url = Uri.parse(URIsAPI.uri_login);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> dados = {
        'login': _userNameController.text,
        'senha': _passwordController.text,
      };

      String body = jsonEncode(dados);

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)['token'];
        await _sharedPreferences.setString('token', 'Bearer $token');
        if (!mounted) return;
        Usuario usuario = Usuario();
        try {
          final resposta = await usuario.getHttp(usuario.montaURL(
              URIsAPI.uri_dados_usuarios, {'login': _userNameController.text}));
          if (resposta.statusCode == 200) {
            usuario =
                Usuario.fromJson(jsonDecode(utf8.decode(resposta.bodyBytes)));
            await _sharedPreferences.setString('id', usuario.id!);
            await _sharedPreferences.setString('login', usuario.login!);
            await _sharedPreferences.setString(
                'tipo_usuario_id', '${usuario.tipoUsuario!.id}');
            await _sharedPreferences.setString(
                'tipo_usuario_desc', usuario.tipoUsuario!.descricao!);

            // print(
            //     "${usuario.id} | ${usuario.login} | ${usuario.tipoUsuario!.id}");
            if (usuario.tipoUsuario!.id == 1) {
              await _sharedPreferences.setString(
                  'home_page', AppRoutes.supervisorHomePage);
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.supervisorHomePage);
            } else {
              await _sharedPreferences.setString(
                  'home_page', AppRoutes.bolsistaHomePage);
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.bolsistaHomePage);
            }
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text("Algo deu errado", textAlign: TextAlign.center),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 5),
            ));
          }
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("Algo deu errado", textAlign: TextAlign.center),
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 5),
          ));
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content:
              Text("msg_erro_usuario_senha".tr, textAlign: TextAlign.center),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
        ));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_de_rede".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
    }
  }
}
