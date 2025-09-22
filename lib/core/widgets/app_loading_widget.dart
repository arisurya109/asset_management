import 'package:flutter/material.dart';

import '../core.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: AppColors.kBase));
  }
}
