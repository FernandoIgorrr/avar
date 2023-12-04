import 'package:avar/core/app_export.dart';
import 'package:avar/domain/computador.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarComputadoresTudo extends StatefulWidget {
  const ListarComputadoresTudo({Key? key}) : super(key: key);

  @override
  State<ListarComputadoresTudo> createState() => _ListarComputadoresTudoState();
}

class _ListarComputadoresTudoState extends State<ListarComputadoresTudo> {
  late Future<List<ComputadorListar>> computadores;
  late ComputadorListar computador;

  @override
  void initState() {
    super.initState();
    computador = ComputadorListar();
    computadores = computador.listarComputadoresTudo(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_listar_pc_tudo".tr),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          decoration: AppDecoration.fillOnPrimary,
          child: FutureBuilder<List<ComputadorListar>>(
              future: computadores,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    //shrinkWrap: true,
                    itemBuilder: (context, index) {
                      ComputadorListar computador = snapshot.data![index];
                      return Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: 15.v),
                        decoration: BoxDecoration(
                          color: appTheme.blackLight,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ExpansionTile(
                          title: Align(
                            alignment: const Alignment(0.2, 0),
                            child: Text(
                              computador.tombamento!,
                            ),
                          ),
                          subtitle: Align(
                              alignment: const Alignment(0.2, 0),
                              child: Text(
                                  "${computador.modelo!} - ${computador.predio!}")),
                          collapsedIconColor: appTheme.blueGray100,
                          tilePadding: EdgeInsets.symmetric(
                              vertical: 0.v, horizontal: 0.h),
                          children: <Widget>[
                            Text(computador.descricao!),
                            Text(computador.estado!),
                            Text(computador.serial!),
                            Text(computador.sistemaOperacional!),
                            Text(computador.ram!),
                            Text(computador.ramDdr!),
                            Text(computador.hd!),
                            Text(computador.complexo!),
                            Text(computador.predio!),
                            Text(computador.andar!),
                            Text(computador.comodo!),
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
}
