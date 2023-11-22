import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  CustomListView(
      {Key? key,
      required this.itemCount,
      required this.widgets,
      this.textColor,
      this.title,
      this.subtitle})
      : super(
          key: key,
        );
  final int itemCount;

  final List<Widget> widgets;

  final Color? textColor;

  final Text? title;

  final Text? subtitle;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return CustomExpansionTile(
          index: index,
          textColor: textColor,
          title: title,
          subtitle: subtitle,
          widgets: widgets,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 0);
      },
    );
  }
}

class CustomExpansionTile extends StatelessWidget {
  final int index;

  final List<Widget> widgets;

  final Color? textColor;

  final Text? title;

  final Text? subtitle;

  CustomExpansionTile(
      {required this.index,
      required this.widgets,
      this.textColor,
      this.title,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
          title: ListTile(
            title: title,
            subtitle: subtitle,
          ),
          children: widgets
          // [
          //   Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: Text('Conteúdo do Tile $index'),
          //   ),
          // ],
          ),
    );
  }
}
