import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileLScaffold;
  final Widget mobileMScaffold;

  const ResponsiveLayout({
    super.key,
    required this.mobileLScaffold,
    required this.mobileMScaffold,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 365) {
          return mobileMScaffold;
        } else {
          return mobileLScaffold;
        }
      },
    );
  }
}
