import 'package:avar/core/app_export.dart';
import 'package:avar/domain/Patrimonio.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class CadastrarPatrimonioPage extends StatefulWidget {
  const CadastrarPatrimonioPage({Key? key}) : super(key: key);

  @override
  State<CadastrarPatrimonioPage> createState() =>
      CadastrarPatrimonioPageState();
}

class CadastrarPatrimonioPageState extends State<CadastrarPatrimonioPage> {
  TextEditingController tombamentoController = TextEditingController();

  TextEditingController descricaoController = TextEditingController();

  TextEditingController estadoController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_cadastrar_patrimonio".tr),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 8.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(height: 10.v),
                      _buildDescricao(context),
                      SizedBox(height: 12.v),
                      Text(
                        "lbl_estado".tr,
                        style: theme.textTheme.titleLarge,
                      ),
                      SizedBox(height: 12.v),
                      _buildEstado(context),
                      SizedBox(height: 14.v),
                      Text(
                        "lbl_tipo".tr,
                        style: theme.textTheme.titleLarge,
                      ),
                      SizedBox(height: 10.v),
                      Container(
                        height: 40.v,
                        width: 200.h,
                        padding: EdgeInsets.all(4.h),
                        decoration: AppDecoration.fillBlueGray.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder10,
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgArrowBotown1,
                          height: 31.adaptSize,
                          width: 31.adaptSize,
                          alignment: Alignment.centerRight,
                        ),
                      ),
                      SizedBox(height: 51.v),
                      _buildCadastrar(context),
                      Spacer(),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 21.h),
                      //   child: Text(
                      //     "lbl_patrimonio".tr,
                      //     style: theme.textTheme.titleMedium,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.h),
                // child: SizedBox(
                //   height: 543.v,
                //   child: VerticalDivider(
                //     width: 6.h,
                //     thickness: 6.v,
                //     indent: 6.h,
                //     endIndent: 187.h,
                //   ),
                // ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }

  /// Section Widget
  Widget _buildTombamento(BuildContext context) {
    return CustomTextFormField(
      controller: tombamentoController,
      textInputType: TextInputType.number,
      textStyle: TextStyle(color: appTheme.black900),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildDescricao(BuildContext context) {
    return CustomTextFormField(
      controller: descricaoController,
      textStyle: TextStyle(color: appTheme.black900),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 5.h,
        vertical: 12.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildEstado(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {"id": 2200, "descricao": "Cadeira"},
      {"id": 2201, "descricao": "Mesa"},
      {"id": 2202, "descricao": "Geladeira"},
      {"id": 2203, "descricao": "Microondas"},
      {"id": 2204, "descricao": "Monitor"},
      {"id": 2205, "descricao": "Computador"},
    ];
    return CustomDropDownMenu(items: items);
  }

  Widget _buildCadastrar(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_cadastrar".tr,
      margin: EdgeInsets.only(
        left: 27.h,
        right: 6.h,
      ),
      alignment: Alignment.centerRight,
    );
  }
}
