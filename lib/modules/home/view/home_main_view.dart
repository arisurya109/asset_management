import 'package:flutter/material.dart';
import 'package:asset_management/features/asset_brand/asset_brand_export.dart';
import 'package:asset_management/features/asset_category/asset_category_export.dart';
import 'package:asset_management/features/asset_model/asset_model_export.dart';
import 'package:asset_management/features/asset_type/asset_type_export.dart';
import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/location/location_export.dart';
import 'package:asset_management/features/printer/presentation/bloc/printer/printer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMainView extends StatefulWidget {
  const HomeMainView({super.key});

  @override
  State<HomeMainView> createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
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
        actions: [
          IconButton(
            onPressed: () {
              refresh();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
