import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_brand/asset_brand_export.dart';
import 'package:asset_management/features/asset_category/asset_category_export.dart';
import 'package:asset_management/features/asset_model/asset_model_export.dart';
import 'package:asset_management/features/asset_type/asset_type_export.dart';
import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/location/location_export.dart';
import 'package:asset_management/features/printer/presentation/bloc/printer/printer_bloc.dart';
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
      'view': Scaffold(),
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
  void initState() {
    context.read<PrinterBloc>().add(OnGetIpPrinter());
    context.read<AssetTypeBloc>().add(OnGetAllAssetType());
    context.read<AssetBrandBloc>().add(OnGetAllAssetBrand());
    context.read<AssetCategoryBloc>().add(OnGetAllAssetCategory());
    context.read<AssetModelBloc>().add(OnGetAllAssetModel());
    context.read<LocationBloc>().add(OnGetAllLocation());
    context.read<AssetsBloc>().add(OnGetAllAssets());
    super.initState();
  }

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
