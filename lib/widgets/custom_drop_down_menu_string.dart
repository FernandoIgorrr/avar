import 'dart:ffi';

import 'package:avar/theme/theme_helper.dart';
import 'package:avar/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenuString extends StatefulWidget {
  CustomDropDownMenuString({
    super.key,
    required this.items,
    this.selectedItemId,
    this.selectedItemIdController,
    this.descName,
    this.reloadElement,
  });

  final List<Map<String, dynamic>> items;
  String? selectedItemId;
  final TextEditingController? selectedItemIdController;
  final String? descName;
  final ValueNotifier<String>? reloadElement;

  @override
  State<CustomDropDownMenuString> createState() =>
      _CustomDropDownMenuStringState(items, selectedItemId,
          selectedItemIdController, descName, reloadElement);
}

class _CustomDropDownMenuStringState extends State<CustomDropDownMenuString> {
  _CustomDropDownMenuStringState(
    this.items,
    this.selectedItemId,
    this.selectedItemIdController,
    this.descName,
    this.reloadElement,
  );

  final List<Map<String, dynamic>> items;
  final TextEditingController? selectedItemIdController;
  String? selectedItemId;
  final String? descName;
  final ValueNotifier<String>? reloadElement;
  @override
  void initState() {
    widget.selectedItemIdController?.text =
        items.first[descName ?? 'descricao'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        right: 0.0,
        bottom: 0,
        left: 0.0,
      ),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
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
                return DropdownMenuItem<String>(
                  alignment: Alignment.center,
                  value: item[descName ?? 'descricao'],
                  child: SizedBox(
                    // height: 0.adaptSize,
                    width: 200.adaptSize,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        item[descName] ?? item['descricao'],
                        //textAlign: TextAlign.center,
                        maxLines: 3,
                        style: theme.textTheme.titleMedium!
                            .copyWith(color: appTheme.black900),
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: (String? value) async {
                setState(() {
                  selectedItemId = value!;
                  widget.selectedItemIdController?.text = value;
                  reloadElement?.value = value;
                });
              },
              borderRadius: BorderRadius.circular(10.0),
              dropdownColor: appTheme.blueGray100),
        ],
      ),
    );
  }
}
