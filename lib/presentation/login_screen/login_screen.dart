import 'package:flutter/material.dart';

import 'package:avar/core/app_export.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(
          horizontal: 37.h,
          vertical: 15.v,
        ),
        child: Column(
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgLogo2,
              height: 64.v,
              width: 222.h,
            ),
            CustomTextFormField(
              controller: userNameController,
              hintText: "Nome de usuário",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 11.h, vertical: 17.v),
            ),
          ],
        ),
      ),
    );
  }
}
