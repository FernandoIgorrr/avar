import 'package:avar/domain/usuario.dart';
import 'package:flutter/material.dart';
import 'package:avar/core/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomNavigationDrawer extends StatelessWidget {
  const CustomNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: appTheme.blackLight,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildMenuItems(context)],
        )),
      );

  // Widget build(BuildContext context) => Theme(data: Theme.of(context).copyWith(canvasColor: appTheme.blackLight), child: Drawer());

  Widget buildHeader(BuildContext context) => Container(
        color: appTheme.black900,
      );

  Widget buildMenuItems(BuildContext context) => Container(
        //padding: const EdgeInsets.only(top: 20, bottom: 20, left: 50),
        color: appTheme.purple500,
        child: Wrap(
          children: [
            ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              leading: Icon(
                Icons.home_outlined,
                color: appTheme.blueGray100,
                size: 35.adaptSize,
              ),
              title:
                  Text('Home', style: CustomTextStyles.titleLargeOnblueGray100),
              onTap: () async {
                String? homePage = await Usuario.recuperarHomePage();
                Navigator.of(context).pushReplacementNamed(homePage!);
              },
            ),
            ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              leading: Icon(
                Icons.assured_workload,
                color: appTheme.blueGray100,
                size: 35.adaptSize,
              ),
              title: Text('Patrimônio',
                  style: CustomTextStyles.titleLargeOnblueGray100),
              onTap: () async {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.patrimoniosHomePage);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.password,
                color: appTheme.blueGray100,
                size: 35.adaptSize,
              ),
              title: Text('Trocar senha',
                  style: CustomTextStyles.titleLargeOnblueGray100),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.alterarSenha);
              },
            ),
            SizedBox(
                height: 475.v, child: Container(color: appTheme.blackLight)),
            ListTile(
              leading: Icon(
                Icons.exit_to_app_outlined,
                color: appTheme.blueGray100,
                size: 35.adaptSize,
              ),
              title:
                  Text('Sair', style: CustomTextStyles.titleLargeOnblueGray100),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.loginScreen);
              },
            ),
          ],
        ),
      );
}
