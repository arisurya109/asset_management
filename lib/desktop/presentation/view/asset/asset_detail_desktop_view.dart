import 'package:flutter/material.dart';

import '../../components/app_header_desktop.dart';

class AssetDetailDesktopView extends StatelessWidget {
  const AssetDetailDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeaderDesktop(title: 'Asset Detail', withBackButton: true),

        Center(child: Text('Asset Detail')),
      ],
    );
  }
}
