import 'package:flutter/material.dart';

class AppAssetImg extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final Color color;

  const AppAssetImg(
    this.path, {
    super.key,
    this.width = 22,
    this.height = 22,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(path, width: width, height: height, color: color);
  }
}
