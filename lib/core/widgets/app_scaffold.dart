import 'package:flutter/material.dart';

import '../utils/colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget? appBarActions;
  const AppScaffold({
    super.key,
    required this.body,
    required this.title,
    this.appBarActions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
        actions: appBarActions != null ? [appBarActions!] : null,
      ),
      body: body,
    );
  }
}
