import 'package:flutter/material.dart';

class AppAssetImg extends StatelessWidget {
  final String path;
  final double width;
  final double height;

  const AppAssetImg(this.path, {super.key, this.width = 24, this.height = 24});

  @override
  Widget build(BuildContext context) {
    return Image.asset(path, width: width, height: height);
  }
}
