import 'package:avar/core/app_export.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarAlienamentosTudo extends StatefulWidget {
  const ListarAlienamentosTudo({Key? key}) : super(key: key);

  @override
  State<ListarAlienamentosTudo> createState() => _ListarAlienamentosTudoState();
}

class _ListarAlienamentosTudoState extends State<ListarAlienamentosTudo> {
  TextEditingController _searchController = TextEditingController();

  ValueNotifier<String> _searchNotifier = ValueNotifier<String>("");

  late Future<List<AlienamentoListar>> alienamentos;
  late AlienamentoListar alienamento;

  @override
  void initState() {
    super.initState();
    alienamento = AlienamentoListar();
    alienamentos = alienamento.listarAlienamentosTudo();
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
                    return alienamento.listarAlienamentosWidget(alienamentos);
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
    final alienamentos0 = await alienamento.listarAlienamentosTudo();
    final pts = alienamentos0.where((element) {
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
      alienamentos = Future.value(pts);
      _searchNotifier.value = query;
    });
  }
}
