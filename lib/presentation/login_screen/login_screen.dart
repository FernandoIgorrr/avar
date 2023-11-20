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
                  hintText: "lbl_usu_rio".tr,
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
      var url = Uri.parse("http://10.0.2.2:8080/api/auth/login");

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

      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        String token = jsonDecode(response.body)['token'];
        await _sharedPreferences.setString('token', 'Token $token');
        if (!mounted) return;
        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.supervisorHomePage);
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          content:
              Text("Usuário ou senha inválidos", textAlign: TextAlign.center),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 5),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('Não foi possível se connectar ao servidor',
            textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 5),
      ));
    }
  }
}
