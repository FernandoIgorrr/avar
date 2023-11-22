import 'package:avar/core/app_export.dart';
import 'package:avar/domain/Patrimonio.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore_for_file: must_be_immutable
class ListarPatrimoniosTudo extends StatefulWidget {
  const ListarPatrimoniosTudo({Key? key}) : super(key: key);

  @override
  State<ListarPatrimoniosTudo> createState() => _ListarPatrimoniosTudoState();
}

class _ListarPatrimoniosTudoState extends State<ListarPatrimoniosTudo> {
  late Future<List<PatrimonioListar>> patrimonios;

  @override
  void initState() {
    super.initState();
    patrimonios = listar_patrimonios_tudo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_listar_tudo".tr),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnPrimary,
          child: FutureBuilder<List<PatrimonioListar>>(
              future: patrimonios,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  //return CustomListView(itemCount:  snapshot.data!.length, widgets: widgets)
                  return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      PatrimonioListar patrimonio = snapshot.data![index];
                      return Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: appTheme.blackLight,
                          borderRadius: BorderRadius.circular(10.0),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     spreadRadius: 3,
                          //     blurRadius: 5,
                          //     offset: Offset(0, 3),
                          //   ),
                          // ],
                        ),
                        child: Center(
                          child: ExpansionTile(
                            trailing: SizedBox(
                              width: 0,
                            ),

                            title: Center(
                              child: Text(
                                patrimonio.tombamento!,
                              ),
                            ),

                            subtitle: Center(
                                child: Text(patrimonio.tipo! +
                                    " - " +
                                    patrimonio.predio!)),
                            // title: ListTile(
                            //   // shape: RoundedRectangleBorder(
                            //   //   borderRadius: BorderRadius.circular(10.0),
                            //   // ),
                            //   textColor: appTheme.blueGray100,
                            //   title: Text(
                            //       textAlign: TextAlign.center,
                            //       patrimonio.tombamento!),
                            //   subtitle: Text(
                            //       textAlign: TextAlign.center,
                            //       patrimonio.tipo! + " - " + patrimonio.predio!),
                            // ),
                            children: <Widget>[
                              Text(
                                patrimonio.descricao!,
                              ),
                              Text(patrimonio.estado!),
                              Text(patrimonio.complexo!),
                              Text(patrimonio.predio!),
                              Text(patrimonio.andar!),
                              Text(patrimonio.comodo!),
                            ],
                            collapsedIconColor: appTheme.blueGray100,
                            tilePadding: EdgeInsets.symmetric(
                                vertical: 0.v, horizontal: 0.h),
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 0);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return const LinearProgressIndicator();
              }),
        ),
        bottomNavigationBar: CustomBottomBar(),
      ),
    );
  }

  Future<List<PatrimonioListar>> listar_patrimonios_tudo() async {
    String? token = await recuperarToken();
    print('Token : ${token}');
    if (token == '' || token == null) {
      // if (!mounted) return new List<Patrimonio>();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("msg_erro_autorizacao".tr, textAlign: TextAlign.center),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ));
      throw Exception("msg_erro_autorizacao".tr);
    } else {
      var url = Uri.parse(URIsAPI.uri_listar_patrimonios_tudo);

      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      });

      if (response.statusCode == 200) {
        List listaPatrimonios = json.decode(response.body);
        return listaPatrimonios
            .map((json) => PatrimonioListar.fromJson(json))
            .toList();
      } else {
        throw Exception("msg_erro_autorizacao".tr);
      }
    }
  }

  Future<String?> recuperarToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
