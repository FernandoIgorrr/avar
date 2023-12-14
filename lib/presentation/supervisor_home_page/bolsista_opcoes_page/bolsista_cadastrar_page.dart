import 'package:avar/core/app_export.dart';

import 'package:avar/domain/usuario.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore_for_file: must_be_immutable
class CadastrarBolsistaPage extends StatefulWidget {
  const CadastrarBolsistaPage({Key? key}) : super(key: key);

  @override
  State<CadastrarBolsistaPage> createState() => CadastrarBolsistaPageState();
}

class CadastrarBolsistaPageState extends State<CadastrarBolsistaPage> {
  TextEditingController _loginController = TextEditingController();

  TextEditingController _nomeController = TextEditingController();

  TextEditingController _matriculaController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _telefoneController = TextEditingController();

  TextEditingController _tipoBolsistaController = TextEditingController();

  //TextEditingController _dataChegadaController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late DateTime _selectedDate;

  late TipoBolsista tipo;

  late BolsistaCadastrar bolsista;

  @override
  void initState() {
    super.initState();
    tipo = TipoBolsista();
    _selectedDate = DateTime(DateTime.now().year);
    bolsista = BolsistaCadastrar();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2017),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) {
        return FittedBox(
          child: Theme(
            data: ThemeData(
                primaryColor: appTheme.black900,
                backgroundColor: appTheme.purple500),
            child: child!,
          ),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppbarTitle(text: "lbl_cadastrar_bolsista".tr),
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
                            "lbl_login".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildLogin(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_nome".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildNome(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_matricula".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildMatricula(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_email".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildEmail(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_telefone".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildTelefone(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_data_inicio".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          _buildDataInicio(context),
                          SizedBox(height: 12.v),
                          Text(
                            "lbl_tipo_bolsista".tr,
                            style: theme.textTheme.titleLarge,
                          ),
                          SizedBox(height: 12.v),
                          FutureBuilder<Widget>(
                            future: _buildTipo(context),
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
                          _buildCadastrar(context),
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

  Widget _buildLogin(BuildContext context) {
    return CustomTextFormField(
      controller: _loginController,
      validator: (descricao) {
        if (descricao == null || descricao.isEmpty) {
          return 'Campo login vazio!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildNome(BuildContext context) {
    return CustomTextFormField(
      controller: _nomeController,
      textInputType: TextInputType.name,
      validator: (nome) {
        if (nome == null || nome.isEmpty) {
          return 'Nome vazio!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildMatricula(BuildContext context) {
    return CustomTextFormField(
      controller: _matriculaController,
      textInputType: TextInputType.number,
      validator: (tombamento) {
        if (tombamento == null || tombamento.isEmpty) {
          return 'Matricula vazia!';
        } else if (!RegExp(r'^[0-9]+$').hasMatch(_matriculaController.text)) {
          return 'A matrícula aceita apenas números!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: _emailController,
      textInputType: TextInputType.emailAddress,
      validator: (email) {
        if (email == null || email.isEmpty) {
          return 'Email vazio!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildTelefone(BuildContext context) {
    return CustomTextFormField(
      controller: _telefoneController,
      textInputType: TextInputType.phone,
      validator: (telefone) {
        if (telefone == null || telefone.isEmpty) {
          return 'Email vazio!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  Future<Widget> _buildTipo(BuildContext context) async {
    List<Map<String, dynamic>> items;
    items = await tipo.listarTipos();
    return CustomDropDownMenu(
      selectedItemIdController: _tipoBolsistaController,
      items: items,
      selectedItemId: items.first['id'],
    );
  }

  Widget _buildDataInicio(BuildContext context) {
    return CustomTextFormField(
      controller: TextEditingController(
        text: _selectedDate != null
            ? DateFormat('dd/MM/yyyy').format(_selectedDate)
            : '',
      ),
      readOnly: true,
      textInputType: TextInputType.datetime,
      suffix: IconButton(
        icon: const Icon(Icons.calendar_today),
        onPressed: () => _selectDate(context),
      ),
      validator: (data) {
        if (data == null || data.isEmpty) {
          return 'Data vazia!';
        }
        return null;
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: 0.h,
        vertical: 12.v,
      ),
    );
  }

  Widget _buildCadastrar(BuildContext context) {
    return CustomElevatedButton(
        text: "lbl_cadastrar".tr,
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
      BolsistaCadastrar bolsista = BolsistaCadastrar(
        matricula: _matriculaController.text,
        login: _loginController.text,
        nome: _nomeController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        tipoBolsista: int.parse(_tipoBolsistaController.text),
        dataChegada: _selectedDate,
      );
      try {
        var response = await bolsista.postHttp(
            bolsista.montaURL(URIsAPI.uri_cadastrar_bolsista, null), bolsista);

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
