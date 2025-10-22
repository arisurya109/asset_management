import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../components/app_dashboard.dart';
import 'package:asset_management/features/asset_brand/asset_brand_export.dart';
import 'package:asset_management/features/asset_category/asset_category_export.dart';
import 'package:asset_management/features/asset_model/asset_model_export.dart';
import 'package:asset_management/features/asset_type/asset_type_export.dart';
import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/location/location_export.dart';
import 'package:asset_management/features/printer/presentation/bloc/printer/printer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewNew extends StatefulWidget {
  const HomeViewNew({super.key});

  @override
  State<HomeViewNew> createState() => _HomeViewNewState();
}

class _HomeViewNewState extends State<HomeViewNew> {
  refresh() {
    context.read<PrinterBloc>().add(OnGetIpPrinter());
    context.read<AssetTypeBloc>().add(OnGetAllAssetType());
    context.read<AssetBrandBloc>().add(OnGetAllAssetBrand());
    context.read<AssetCategoryBloc>().add(OnGetAllAssetCategory());
    context.read<AssetModelBloc>().add(OnGetAllAssetModel());
    context.read<LocationBloc>().add(OnGetAllLocation());
    context.read<AssetsBloc>().add(OnGetAllAssets());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Management'),
        elevation: 0,
        actionsPadding: EdgeInsets.only(right: 24),
        actions: [
          IconButton(
            onPressed: () {
              refresh();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(24, 0, 24, 5),
        children: [AppSpace.vertical(16), AppDashboard()],
      ),
    );
  }
}
