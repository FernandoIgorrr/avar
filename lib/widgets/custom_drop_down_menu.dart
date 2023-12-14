import 'package:avar/theme/theme_helper.dart';
import 'package:avar/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatefulWidget {
  CustomDropDownMenu({
    super.key,
    required this.items,
    this.selectedItemId,
    this.selectedItem,
    this.selectedItemIdController,
    this.descName,
    this.reloadElement,
    this.selectedItemController,
  });

  final List<Map<String, dynamic>> items;
  int? selectedItemId;
  final TextEditingController? selectedItemIdController;
  final TextEditingController? selectedItemController;
  String? selectedItem;
  final String? descName;
  final ValueNotifier<int>? reloadElement;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState(
      items,
      selectedItemId,
      selectedItem,
      selectedItemIdController,
      selectedItemController,
      descName,
      reloadElement);
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  _CustomDropDownMenuState(
    this.items,
    this.selectedItemId,
    this.selectedItem,
    this.selectedItemIdController,
    this.selectedItemController,
    this.descName,
    this.reloadElement,
  );

  final List<Map<String, dynamic>> items;
  final TextEditingController? selectedItemIdController;
  final TextEditingController? selectedItemController;

  int? selectedItemId;
  String? selectedItem;
  final String? descName;
  final ValueNotifier<int>? reloadElement;
  @override
  void initState() {
    super.initState();

    if (selectedItem == null) {
      widget.selectedItemIdController?.text = items.first['id'].toString();
    } else {
      selectedItemId = items.firstWhere((item) =>
          item[descName ?? 'descricao'].toString() == selectedItem)['id'];
      widget.selectedItemIdController?.text = selectedItemId.toString();
    }
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
              onChanged: (int? value) async {
                setState(() {
                  selectedItemId = value!;
                  widget.selectedItemIdController?.text = value.toString();
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
