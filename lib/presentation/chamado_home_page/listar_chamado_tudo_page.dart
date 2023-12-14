import 'package:avar/core/app_export.dart';
import 'package:avar/domain/chamado.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ListarChamadosTudo extends StatefulWidget {
  const ListarChamadosTudo({Key? key}) : super(key: key);

  @override
  State<ListarChamadosTudo> createState() => _ListarChamadosTudoState();
}

class _ListarChamadosTudoState extends State<ListarChamadosTudo> {
  TextEditingController _searchController = TextEditingController();

  ValueNotifier<String> _searchNotifier = ValueNotifier<String>("");

  late Future<List<ChamadoListar>> chamados;
  late ChamadoListar chamado;

  @override
  void initState() {
    super.initState();
    chamado = ChamadoListar();
    chamados = chamado.listarChamadosTudo();
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
                    return chamado.listarChamadosWidget(chamados);
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
    final chamados0 = await chamado.listarChamadosTudo();
    final pts = chamados0.where((element) {
      String id = element.id.toString();
      String criador = element.criador!.toLowerCase();
      String complexo = element.complexo!.toLowerCase();
      String predio = element.predio!.toLowerCase();
      String andar = element.predio!.toLowerCase();
      String comodo = element.comodo!.toLowerCase();
      String descricao = element.descricao!.toLowerCase();
      String tipo = element.tipo!.toLowerCase();
      String titulo = element.titulo!.toLowerCase();
      String estado = element.estado!.toLowerCase();

      return id.contains(query) ||
          criador.contains(query) ||
          comodo.contains(query) ||
          complexo.contains(query) ||
          predio.contains(query) ||
          andar.contains(query) ||
          titulo.contains(query) ||
          descricao.contains(query) ||
          estado.contains(query) ||
          tipo.contains(query);
    }).toList();

    setState(() {
      chamados = Future.value(pts);
      _searchNotifier.value = query;
    });
  }
}
