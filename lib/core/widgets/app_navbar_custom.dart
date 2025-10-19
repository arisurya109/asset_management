import 'package:flutter/material.dart';

import 'app_navbar_item.dart';

// ignore: must_be_immutable
class AppNavbarCustom extends StatelessWidget {
  final List itemNavbar;
  int? selectedItem;
  Function(int index) onTap;

  AppNavbarCustom({
    super.key,
    required this.itemNavbar,
    this.selectedItem = 0,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 75,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0XFFDBE0E5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(itemNavbar.length, (index) {
            final item = itemNavbar[index];
            return AppNavbarItem(
              isSelected: index == selectedItem,
              assets: index == selectedItem ? item['selected'] : item['icon'],
              label: item['title'],
              onTap: () => onTap.call(index),
            );
          }),
        ),
      ),
    );
  }
}
