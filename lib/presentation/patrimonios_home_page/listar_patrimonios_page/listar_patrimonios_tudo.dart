import 'package:avar/core/app_export.dart';
import 'package:avar/domain/patrimonio.dart';
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
    patrimonios = listarPatrimoniosTudo();
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
                  return ListView.separated(
                    //padding: const EdgeInsets.all(20.0),

                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      PatrimonioListar patrimonio = snapshot.data![index];
                      return Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          color: appTheme.blackLight,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ExpansionTile(
                          title: Align(
                            alignment: const Alignment(0.2, 0),
                            child: Text(
                              patrimonio.tombamento!,
                            ),
                          ),
                          subtitle: Align(
                              alignment: const Alignment(0.2, 0),
                              child: Text(
                                  "${patrimonio.tipo!} - ${patrimonio.predio!}")),
                          collapsedIconColor: appTheme.blueGray100,
                          tilePadding: EdgeInsets.symmetric(
                              vertical: 0.v, horizontal: 0.h),
                          children: <Widget>[
                            Text(patrimonio.descricao!),
                            Text(patrimonio.estado!),
                            Text(patrimonio.complexo!),
                            Text(patrimonio.predio!),
                            Text(patrimonio.andar!),
                            Text(patrimonio.comodo!),
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 0);
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

  Future<List<PatrimonioListar>> listarPatrimoniosTudo() async {
    String? token = await recuperarToken();
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
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': token
      };
      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List listaPatrimonios = jsonDecode(utf8.decode(response.bodyBytes));
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
