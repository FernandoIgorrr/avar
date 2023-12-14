import 'package:avar/core/app_export.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarManejosTudo extends StatefulWidget {
  const ListarManejosTudo({Key? key}) : super(key: key);

  @override
  State<ListarManejosTudo> createState() => _LListarManejosTudoState();
}

class _LListarManejosTudoState extends State<ListarManejosTudo> {
  TextEditingController _searchController = TextEditingController();

  ValueNotifier<String> _searchNotifier = ValueNotifier<String>("");

  late Future<List<ManejoListar>> manejos;
  late ManejoListar manejo;

  @override
  void initState() {
    super.initState();
    manejo = ManejoListar();
    manejos = manejo.listarManejosTudo();
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
                    return manejo.listarManejosWidget(manejos);
                  }),
            ],
          ),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  Future<void> searchBox(String query) async {
    query = query.toLowerCase();
    final manejos0 = await manejo.listarManejosTudo();
    final pts = manejos0.where((element) {
      String id = element.id.toString();
      String tombamento = element.tombamento ?? "";
      String tipo = element.tipo!.toLowerCase();
      String nome = element.nome!.toLowerCase();

      return id.contains(query) ||
          tombamento.contains(query) ||
          tipo.contains(query) ||
          nome.contains(query);
    }).toList();

    setState(() {
      manejos = Future.value(pts);
      _searchNotifier.value = query;
    });
  }
}
