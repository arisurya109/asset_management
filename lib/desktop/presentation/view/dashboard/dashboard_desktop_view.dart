import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:flutter/material.dart';

class DashboardDesktopView extends StatelessWidget {
  const DashboardDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeaderDesktop(title: 'Dashboard'),
        AppBodyDesktop(),
      ],
    );
  }
}
