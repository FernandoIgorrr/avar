import 'package:avar/core/app_export.dart';
import 'package:avar/domain/computador.dart';
import 'package:avar/domain/patrimonio.dart';
import 'package:avar/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: must_be_immutable
class EditarComputadorPage extends StatefulWidget {
  EditarComputadorPage({Key? key, required this.computador}) : super(key: key);

  ComputadorListar computador;

  @override
  State<EditarComputadorPage> createState() => EditarComputadorPageState();
}

class EditarComputadorPageState extends State<EditarComputadorPage> {
  TextEditingController _tombamentoController = TextEditingController();

  TextEditingController _descricaoController = TextEditingController();

  TextEditingController _estadoController = TextEditingController();

  TextEditingController _serialController = TextEditingController();

  TextEditingController _modeloController = TextEditingController();

  TextEditingController _sistemaOperacionalController = TextEditingController();

  TextEditingController _ramController = TextEditingController();

  TextEditingController _ramddrController = TextEditingController();

  TextEditingController _hdController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late EstadoPatrimonio estado;

  late Modelo modelo;
  late SistemaOperacional sistemaOperacional;
  late RAM ram;
  late RAMDDR ramddr;
  late HD hd;

  @override
  void initState() {
    super.initState();

    estado = EstadoPatrimonio();

    modelo = Modelo();
    sistemaOperacional = SistemaOperacional();
    ram = RAM();
    ramddr = RAMDDR();
    hd = HD();

    _tombamentoController.text = widget.computador.tombamento.toString();
    _descricaoController.text = widget.computador.descricao.toString();
    _serialController.text = widget.computador.serial.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_alterar_dados".tr),
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
                          SizedBox(height: 12.v),
                          _buildDescricao(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_estado".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildEstados(context),
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
                          SizedBox(height: 14.v),
                          Text(
                            "lbl_serial".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildSerial(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_modelo".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildModelos(context),
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
                            "lbl_sistema_operacional".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildSistemasOperacionais(context),
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
                            "lbl_ram".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildRAM(context),
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
                            "lbl_ram_ddr".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildRAMDDR(context),
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
                            "lbl_hd".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildHD(context),
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
                          SizedBox(height: 30.v),
                          _buildAlterar(context),
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
      controller: _tombamentoController,
      textInputType: TextInputType.number,
      validator: (tombamento) {
        if (tombamento == null || tombamento.isEmpty) {
          return 'Tombamento vazio!';
        } else if (!RegExp(r'^[0-9]+$').hasMatch(_tombamentoController.text)) {
          return 'O tombamento aceita apenas números!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildDescricao(BuildContext context) {
    return CustomTextFormField(
      controller: _descricaoController,
      maxLines: 3,
      validator: (descricao) {
        if (descricao == null || descricao.isEmpty) {
          return 'Descrição vazia!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildSerial(BuildContext context) {
    return CustomTextFormField(
      controller: _serialController,
      maxLines: 1,
      validator: (serial) {
        if (serial == null || serial.isEmpty) {
          return 'Serial vazio!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
    );
  }

  /// Section Widget
  Future<Widget> _buildEstados(BuildContext context) async {
    List<Map<String, dynamic>> items = await estado.listarEstados();
    return CustomDropDownMenu(
      selectedItem: widget.computador.estado,
      selectedItemIdController: _estadoController,
      items: items,
    );
  }

  Future<Widget> _buildModelos(BuildContext context) async {
    List<Map<String, dynamic>> items = await modelo.listarModelos();
    return CustomDropDownMenu(
      selectedItem: widget.computador.modelo,
      selectedItemIdController: _modeloController,
      items: items,
    );
  }

  Future<Widget> _buildSistemasOperacionais(BuildContext context) async {
    List<Map<String, dynamic>> items =
        await sistemaOperacional.listarSistemasOperacionais();
    return CustomDropDownMenu(
      selectedItem: widget.computador.sistemaOperacional,
      selectedItemIdController: _sistemaOperacionalController,
      items: items,
    );
  }

  Future<Widget> _buildRAM(BuildContext context) async {
    List<Map<String, dynamic>> items = await ram.listarRams();
    return CustomDropDownMenu(
      selectedItem: widget.computador.ram,
      selectedItemIdController: _ramController,
      items: items,
    );
  }

  Future<Widget> _buildRAMDDR(BuildContext context) async {
    List<Map<String, dynamic>> items = await ramddr.listarRamsDdr();
    return CustomDropDownMenu(
      selectedItem: widget.computador.ramDdr,
      selectedItemIdController: _ramddrController,
      items: items,
    );
  }

  Future<Widget> _buildHD(BuildContext context) async {
    List<Map<String, dynamic>> items = await hd.listarHds();
    return CustomDropDownMenu(
      selectedItem: widget.computador.hd,
      selectedItemIdController: _hdController,
      items: items,
    );
  }

  Widget _buildAlterar(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_alterar".tr,
        margin: EdgeInsets.only(
          left: 15.h,
          right: 15.h,
        ),
        alignment: Alignment.centerRight,
        onPressed: () {
          alterar();
        });
  }

  alterar() async {
    if (_formKey.currentState!.validate()) {
      ComputadorCadastrar computador = ComputadorCadastrar(
          id: widget.computador.id,
          tombamento: _tombamentoController.text,
          descricao: _descricaoController.text,
          estado: int.parse(_estadoController.text),
          serial: _serialController.text,
          modelo: int.parse(_modeloController.text),
          sistemaOperacional: int.parse(_sistemaOperacionalController.text),
          ram: int.parse(_ramController.text),
          ramDdr: int.parse(_ramddrController.text),
          hd: int.parse(_hdController.text),
          localidade: 0,
          alienado: false);
      try {
        var response = await computador.putHttp(
            computador.montaURL(URIsAPI.uri_alterar_dados_computador, null),
            computador);

        if (response.statusCode == 202) {
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
            duration: const Duration(seconds: 2),
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
            duration: const Duration(seconds: 2),
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
          duration: const Duration(seconds: 2),
        ));
      }
    }
  }
}
