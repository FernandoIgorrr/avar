import 'package:avar/core/app_export.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarPatrimoniosTudo extends StatefulWidget {
  const ListarPatrimoniosTudo({Key? key}) : super(key: key);

  @override
  State<ListarPatrimoniosTudo> createState() => _ListarPatrimoniosTudoState();
}

class _ListarPatrimoniosTudoState extends State<ListarPatrimoniosTudo> {
  TextEditingController _searchController = TextEditingController();

  ValueNotifier<String> _searchNotifier = ValueNotifier<String>("");

  late Future<List<PatrimonioListar>> patrimonios;
  late PatrimonioListar patrimonio;

  @override
  void initState() {
    super.initState();
    patrimonio = PatrimonioListar();
    patrimonios = patrimonio.listarPatrimoniosTudo();
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
                    return patrimonio.listarPatrimoniosWidget(patrimonios);
                  }),
            ],
          ),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  Future<void> searchBox(String query) async {
    final patrimonios0 = await patrimonio.listarPatrimoniosTudo();
    final pts = patrimonios0.where((element) {
      String tombamento = element.tombamento ?? "";
      return tombamento.contains(query);
    }).toList();

    setState(() {
      patrimonios = Future.value(pts);
      _searchNotifier.value = query;
    });
  }
}
