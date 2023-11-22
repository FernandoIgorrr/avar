import 'package:avar/theme/theme_helper.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  CustomDropDownMenu({super.key, required this.items});

  final List<Map<String, dynamic>> items;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState(items);
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  _CustomDropDownMenuState(this.items);

  final List<Map<String, dynamic>> items;

  int? selectedItemId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          DropdownButtonFormField<int>(
              value: selectedItemId,
              //decoration: InputDecoration(labelText: 'Selecione um item'),
              decoration: InputDecoration(
                filled: true,
                fillColor: appTheme.blueGray100,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Defina o raio de borda
                ), // Defina a cor de fundo desejada
              ),
              items: items.map((item) {
                return DropdownMenuItem<int>(
                  value: item['id'],
                  child: Text(item['descricao'],
                      style: TextStyle(color: appTheme.black900)),
                );
              }).toList(),
              onChanged: (int? value) {
                setState(() {
                  selectedItemId = value!;
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
