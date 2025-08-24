import 'package:flutter/material.dart';

class AppIconDrawerItem extends StatelessWidget {
  final String path;
  const AppIconDrawerItem(this.path, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(path, height: 24, width: 24);
  }
}
