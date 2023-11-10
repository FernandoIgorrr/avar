import 'package:flutter/material.dart';

import 'package:avar/core/app_export.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

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
            vertical: 15.v,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLogo2,
                height: 64.v,
                width: 222.h,
              ),
              Spacer(
                flex: 45,
              ),
              CustomTextFormField(
                controller: userNameController,
                hintText: "Usuário",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 11.h,
                  vertical: 12.v,
                ),
              ),
              SizedBox(height: 20.v),
              CustomTextFormField(
                controller: passwordController,
                hintText: "Senha",
                textInputAction: TextInputAction.done,
                obscureText: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 11.h,
                  vertical: 12.v,
                ),
              ),
              SizedBox(height: 20.v),
              CustomElevatedButton(
                text: "Acessar",
                buttonStyle: CustomButtonStyles.fillPurple,
                buttonTextStyle: theme.textTheme.headlineSmall!,
              ),
              Spacer(
                flex: 54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
