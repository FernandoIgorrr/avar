import 'package:avar/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  CustomDropDownMenu({
    super.key,
    required this.items,
    this.selectedItemId,
    this.selectedItemIdController,
    this.descName,
  });

  final List<Map<String, dynamic>> items;
  int? selectedItemId;
  final TextEditingController? selectedItemIdController;
  final String? descName;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState(
      items, selectedItemId, selectedItemIdController, descName);
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  _CustomDropDownMenuState(this.items, this.selectedItemId,
      this.selectedItemIdController, this.descName);

  final List<Map<String, dynamic>> items;
  final TextEditingController? selectedItemIdController;
  int? selectedItemId;
  final String? descName;

  @override
  void initState() {
    widget.selectedItemIdController?.text = items.first['id'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        right: 70.0,
        bottom: 0,
        left: 70.0,
      ),
      child: Column(
        children: [
          DropdownButtonFormField<int>(
              isExpanded: true,
              alignment: Alignment.center,
              value: selectedItemId,
              decoration: InputDecoration(
                filled: true,
                fillColor: appTheme.blueGray100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: items.map((item) {
                return DropdownMenuItem<int>(
                    alignment: Alignment.center,
                    value: item['id'],
                    child: Align(
                      //alignment: const Alignment(0.2, 0),
                      child: Text(
                        item[descName] ?? item['descricao'],
                        style: TextStyle(color: appTheme.black900),
                      ),
                    )
                    // child: Text(item['descricao'],
                    //     style: TextStyle(color: appTheme.black900)),
                    );
              }).toList(),
              onChanged: (int? value) async {
                setState(() {
                  selectedItemId = value!;
                  widget.selectedItemIdController?.text = value.toString();
                });
              },
              borderRadius: BorderRadius.circular(10.0),
              dropdownColor: appTheme.blueGray100),
          //SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () {
          //     if (selectedItemId != null) {
          //       print('Enviando formulário com ID: $selectedItemId');
          //       // Adicione aqui a lógica para enviar o formulário com o ID selecionado
          //     } else {
          //       print('Nenhum item selecionado');
          //     }
          //   },
          //   child: Text('Enviar Formulário'),
          // ),
        ],
      ),
    );
  }
}
