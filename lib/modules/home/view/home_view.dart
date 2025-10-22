import 'package:asset_management/core/core.dart';

import 'package:asset_management/modules/home/view/home_main_view.dart';
import 'package:asset_management/modules/master/presentation/view/master_view.dart';
import 'package:asset_management/modules/operations/presentation/view/operation_view.dart';
import 'package:asset_management/modules/settings/presentation/view/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/app_navbar_custom.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedNavbar = 0;
  List itemNavbar = [
    {
      'title': 'Home',
      'icon': Assets.iHomeUnselected,
      'selected': Assets.iHomeSelected,
      'view': HomeMainView(),
    },
    {
      'title': 'Operations',
      'icon': Assets.iOperationUnselected,
      'selected': Assets.iOperationSelected,
      'view': OperationView(),
    },
    {
      'title': 'Master',
      'icon': Assets.iMasterUnselected,
      'selected': Assets.iMasterSelected,
      'view': MasterView(),
    },
    {
      'title': 'Settings',
      'icon': Assets.iSettingUnselected,
      'selected': Assets.iSettingSelected,
      'view': SettingsView(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          itemNavbar[_selectedNavbar]['view'],
          AppNavbarCustom(
            itemNavbar: itemNavbar,
            selectedItem: _selectedNavbar,
            onTap: (index) => setState(() {
              _selectedNavbar = index;
            }),
          ),
        ],
      ),
    );
  }
}
