import 'package:avar/core/app_export.dart';
import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({super.key, this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHomeicon1,
      activeIcon: ImageConstant.imgHomeicon1,
      type: BottomBarEnum.Homeicon1,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgMagnifierSearchZoomIcon,
      activeIcon: ImageConstant.imgMagnifierSearchZoomIcon,
      type: BottomBarEnum.Magnifiersearchzoomicon,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgCalendarIcon1,
      activeIcon: ImageConstant.imgCalendarIcon1,
      type: BottomBarEnum.Calendaricon1,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgMenuListNavig,
      activeIcon: ImageConstant.imgMenuListNavig,
      type: BottomBarEnum.Menulistnavig,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.v,
      decoration: BoxDecoration(
        color: appTheme.purple500,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              height: 53.v,
              width: 59.h,
            ),
            activeIcon: CustomImageView(
              imagePath: bottomMenuList[index].activeIcon,
              height: 48.adaptSize,
              width: 48.adaptSize,
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Homeicon1,
  Magnifiersearchzoomicon,
  Calendaricon1,
  Menulistnavig,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
