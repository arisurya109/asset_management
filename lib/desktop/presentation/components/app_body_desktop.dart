import 'package:flutter/material.dart';

class AppBodyDesktop extends StatelessWidget {
  final Widget? body;

  const AppBodyDesktop({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: body,
      ),
    );
  }
}
