import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadScreen extends StatefulWidget {
  LoadScreen({Key? key}) : super(key: key);

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {
  @override
  initState() {
    super.initState();
    verificarUsuario().then((value) => {
          if (value)
            Navigator.pushNamed(context, AppRoutes.loginScreen)
          else
            Navigator.pushNamed(context, AppRoutes.loginScreen)
        });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 37.h,
            top: 133.v,
            right: 37.h,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgLogo1,
                height: 200.adaptSize,
                width: 200.adaptSize,
              ),
              SizedBox(height: 67.v),
              Container(
                height: 8.v,
                width: 300.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> verificarUsuario() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();

    String? token = _sharedPreferences.getString('token');

    if (token == null) return false;

    return true;
  }
}
