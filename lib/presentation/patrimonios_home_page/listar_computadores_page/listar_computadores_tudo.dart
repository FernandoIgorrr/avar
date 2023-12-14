import 'package:avar/core/app_export.dart';
import 'package:avar/domain/computador.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarComputadoresTudo extends StatefulWidget {
  const ListarComputadoresTudo({Key? key}) : super(key: key);

  @override
  State<ListarComputadoresTudo> createState() => _ListarComputadoresTudoState();
}

class _ListarComputadoresTudoState extends State<ListarComputadoresTudo> {
  TextEditingController _searchController = TextEditingController();
  ValueNotifier<String> _searchNotifier = ValueNotifier<String>("");

  late Future<List<ComputadorListar>> computadores;
  late ComputadorListar computador;

  @override
  void initState() {
    super.initState();
    computador = ComputadorListar();
    computadores = computador.listarComputadoresTudo();
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
                    return computador.listarComputadoresWidget(computadores);
                  }),
            ],
          ),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  Future<void> searchBox(String query) async {
    final computadores0 = await computador.listarComputadoresTudo();
    final pts = computadores0.where((element) {
      String tombamento = element.tombamento ?? "";
      String modelo = element.modelo ?? "";

      return tombamento.contains(query) || modelo.contains(query);
    }).toList();

    setState(() {
      computadores = Future.value(pts);
      _searchNotifier.value = query;
    });
  }
}
