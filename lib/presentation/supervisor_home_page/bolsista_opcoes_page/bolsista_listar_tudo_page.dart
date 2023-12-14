import 'package:avar/core/app_export.dart';
import 'package:avar/domain/usuario.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class BolsistaListarTudo extends StatefulWidget {
  const BolsistaListarTudo({Key? key}) : super(key: key);

  @override
  State<BolsistaListarTudo> createState() => _BolsistaListarTudoState();
}

class _BolsistaListarTudoState extends State<BolsistaListarTudo> {
  TextEditingController _searchController = TextEditingController();
  ValueNotifier<String> _searchNotifier = ValueNotifier<String>("");

  late Future<List<BolsistaListar>> bolsistas;
  late BolsistaListar bolsista;

  @override
  void initState() {
    super.initState();
    bolsista = BolsistaListar();
    bolsistas = bolsista.listarBolsistasTudo();
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
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          decoration: AppDecoration.fillOnPrimary,
          child: Column(
            children: [
              SizedBox(
                height: 15.v,
              ),
              CustomTextFormField(
                controller: _searchController,
                textInputType: TextInputType.number,
                hintText: "Pesquisar",
                prefix: const Icon(Icons.search),
                onChanged: searchBox,
              ),
              SizedBox(
                height: 15.v,
              ),
              ValueListenableBuilder<String>(
                  valueListenable: _searchNotifier,
                  builder: (context, value, child) {
                    return bolsista.listarBolsistasWidget(bolsistas);
                  }),
            ],
          ),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  Future<void> searchBox(String query) async {
    final bolsistas0 = await bolsista.listarBolsistasTudo();
    final pts = bolsistas0.where((element) {
      String matricula = element.matricula!.toLowerCase();
      String nome = element.nome!.toLowerCase();
      String login = element.login!.toLowerCase();
      return matricula.contains(query.toLowerCase()) ||
          nome.contains(query) ||
          login.contains(query);
    }).toList();

    setState(() {
      bolsistas = Future.value(pts);
      _searchNotifier.value = query;
    });
  }
}
