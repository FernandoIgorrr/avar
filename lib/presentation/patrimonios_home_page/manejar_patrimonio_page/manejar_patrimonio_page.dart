import 'package:avar/core/app_export.dart';
import 'package:avar/domain/localidade.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:avar/domain/usuario.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ManejarPatrimonioPage extends StatefulWidget {
  ManejarPatrimonioPage({Key? key, required this.patrimonio}) : super(key: key);

  Patrimonio patrimonio;

  @override
  State<ManejarPatrimonioPage> createState() => ManejarPatrimonioPageState();
}

class ManejarPatrimonioPageState extends State<ManejarPatrimonioPage> {
  TextEditingController _tombamentoController = TextEditingController();

  TextEditingController _descricaoController = TextEditingController();

  TextEditingController _estadoController = TextEditingController();

  TextEditingController _tipoController = TextEditingController();

  TextEditingController _complexoAnteriorController = TextEditingController();

  TextEditingController _predioAnteriorController = TextEditingController();

  TextEditingController _andarAnteriorController = TextEditingController();

  TextEditingController _comodoAnteriorController = TextEditingController();

  TextEditingController _complexoPosteriorController = TextEditingController();

  TextEditingController _predioPosteriorController = TextEditingController();

  TextEditingController _andarPosteriorController = TextEditingController();

  TextEditingController _comodoPosteriorController = TextEditingController();

  ValueNotifier<int> _reloadPredios = ValueNotifier<int>(1);

  ValueNotifier<int> _reloadAndares = ValueNotifier<int>(1);

  ValueNotifier<int> _reloadComodos = ValueNotifier<int>(1);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TipoPatrimonio tipo;
  late EstadoPatrimonio estado;

  late Complexo complexo;
  late Predio predio;
  late Andar andar;
  late Comodo comodo;

  @override
  void initState() {
    super.initState();

    tipo = TipoPatrimonio();
    estado = EstadoPatrimonio();

    complexo = Complexo();
    predio = Predio();
    andar = Andar();
    comodo = Comodo();

    _tombamentoController.text = widget.patrimonio.tombamento!;
    _descricaoController.text = widget.patrimonio.descricao!;
    _estadoController.text = widget.patrimonio.estado!.descricao!;
    _tipoController.text = widget.patrimonio.tipoPatrimonio!.descricao!;

    _complexoAnteriorController.text =
        widget.patrimonio.localidade!.andar!.predio!.complexo!.nome!;
    _predioAnteriorController.text =
        widget.patrimonio.localidade!.andar!.predio!.nome!;
    _andarAnteriorController.text = widget.patrimonio.localidade!.andar!.nome!;
    _comodoAnteriorController.text = widget.patrimonio.localidade!.nome!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_manejar_patrimonio".tr),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(horizontal: 30.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.v),
                    child: Form(
                      key: _formKey,
                      child: Column(
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
                          SizedBox(height: 12.v),
                          _buildTipo(context),
                          SizedBox(height: 20.v),
                          SizedBox(
                            width: double.maxFinite,
                            height: 2,
                            child: Container(color: appTheme.blueGray100),
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_localidade_atual".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          SizedBox(
                            width: double.maxFinite,
                            height: 2,
                            child: Container(color: appTheme.blueGray100),
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_complexo".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildComplexo(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_predio".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildPredio(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_andar".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildAndar(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_comodo".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildComodo(context),
                          SizedBox(height: 20.v),
                          SizedBox(
                            width: double.maxFinite,
                            height: 2,
                            child: Container(color: appTheme.blueGray100),
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_nova_localidade".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          SizedBox(
                            width: double.maxFinite,
                            height: 2,
                            child: Container(color: appTheme.blueGray100),
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildComplexoPosterior(context),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const LinearProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Erro: ${snapshot.error}');
                              } else {
                                return snapshot.data ?? const SizedBox();
                              }
                            },
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_predio".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          ValueListenableBuilder<int>(
                            valueListenable: _reloadPredios,
                            builder: (context, value, child) {
                              return FutureBuilder(
                                future: _buildPredioPosterior(context, value),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const LinearProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Erro: ${snapshot.error}');
                                  } else {
                                    return snapshot.data ?? const SizedBox();
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_andar".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          ValueListenableBuilder<int>(
                            valueListenable: _reloadAndares,
                            builder: (context, value, child) {
                              return FutureBuilder(
                                future: _buildAndarPosterior(context, value),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const LinearProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Erro: ${snapshot.error}');
                                  } else {
                                    return snapshot.data ?? const SizedBox();
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_comodo".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          ValueListenableBuilder<int>(
                            valueListenable: _reloadComodos,
                            builder: (context, value, child) {
                              return FutureBuilder(
                                future: _buildComodoPosterior(context, value),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const LinearProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Erro: ${snapshot.error}');
                                  } else {
                                    return snapshot.data ?? const SizedBox();
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: 30.v),
                          _buildManejar(context),
                          SizedBox(height: 50.v),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        endDrawer: const CustomNavigationDrawer(),
      ),
    );
  }

  /// Section Widget
  Widget _buildTombamento(BuildContext context) {
    return CustomTextFormField(
      readOnly: true,
      controller: _tombamentoController,
    );
  }

  /// Section Widget
  Widget _buildDescricao(BuildContext context) {
    return CustomTextFormField(
      readOnly: true,
      controller: _descricaoController,
      maxLines: 3,
    );
  }

  Widget _buildEstado(BuildContext context) {
    return CustomTextFormField(
      readOnly: true,
      controller: _estadoController,
    );
  }

  Widget _buildTipo(BuildContext context) {
    return CustomTextFormField(
      readOnly: true,
      controller: _tipoController,
    );
  }

  Widget _buildComplexo(BuildContext context) {
    return CustomTextFormField(
      readOnly: true,
      controller: _complexoAnteriorController,
    );
  }

  Widget _buildPredio(BuildContext context) {
    return CustomTextFormField(
      readOnly: true,
      controller: _predioAnteriorController,
    );
  }

  Widget _buildAndar(BuildContext context) {
    return CustomTextFormField(
      readOnly: true,
      controller: _andarAnteriorController,
    );
  }

  Widget _buildComodo(BuildContext context) {
    return CustomTextFormField(
      readOnly: true,
      controller: _comodoAnteriorController,
    );
  }

  Future<Widget> _buildComplexoPosterior(BuildContext context) async {
    List<Map<String, dynamic>> items = await complexo.listarComplexos();
    return CustomDropDownMenu(
      reloadElement: _reloadPredios,
      descName: 'nome',
      selectedItemIdController: _complexoPosteriorController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildPredioPosterior(BuildContext context, int value) async {
    List<Map<String, dynamic>> items;
    items = await predio.listarPredios(value);
    _reloadAndares.value = items.first['id'];
    return CustomDropDownMenu(
      reloadElement: _reloadAndares,
      descName: 'nome',
      selectedItemIdController: _predioPosteriorController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildAndarPosterior(BuildContext context, int value) async {
    List<Map<String, dynamic>> items;
    items = await andar.listarAndares(value);
    _reloadComodos.value = items.first['id'];
    return CustomDropDownMenu(
      reloadElement: _reloadComodos,
      descName: 'nome',
      selectedItemIdController: _andarPosteriorController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Future<Widget> _buildComodoPosterior(BuildContext context, int value) async {
    List<Map<String, dynamic>> items;
    items = await comodo.listarComodos(value);
    if (items.isEmpty) {
      return CustomDropDownMenu(
        descName: 'nome',
        selectedItemIdController: _comodoPosteriorController,
        items: items,
      );
    }
    return CustomDropDownMenu(
      descName: 'nome',
      selectedItemIdController: _comodoPosteriorController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Widget _buildManejar(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_manejar".tr,
        margin: EdgeInsets.only(
          left: 15.h,
          right: 15.h,
        ),
        alignment: Alignment.centerRight,
        onPressed: () {
          cadastrar();
        });
  }

  cadastrar() async {
    if (_formKey.currentState!.validate()) {
      String? userID = await Usuario.recuperarID();
      ManejoCadastrar manejoCadastrar = ManejoCadastrar(
          patrimonio: widget.patrimonio.id,
          usuario: userID,
          comodoAnterior: widget.patrimonio.localidade!.id,
          comodoPosterior: int.parse(_comodoPosteriorController.text),
          dataManejo: DateTime.now());
      print("MANEJO: \n${manejoCadastrar.toJson()}");
      try {
        var response = await manejoCadastrar.putHttp(
            manejoCadastrar.montaURL(URIsAPI.uri_cadastrar_manejo, null),
            manejoCadastrar);

        if (response.statusCode == 201) {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(response.body,
                textAlign: TextAlign.center,
                style: TextStyle(color: appTheme.black900)),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.up,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 210,
                left: 15,
                right: 15),
            duration: const Duration(seconds: 3),
          ));
        } else {
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(response.body, textAlign: TextAlign.center),
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.up,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 210,
                left: 15,
                right: 15),
            duration: const Duration(seconds: 3),
          ));
        }
      } catch (e) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("msg_erro_de_rede".tr, textAlign: TextAlign.center),
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.up,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 210,
              left: 15,
              right: 15),
          duration: const Duration(seconds: 3),
        ));
      }
    }
  }
}
