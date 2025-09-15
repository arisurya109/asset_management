import 'package:asset_management/features/asset_preparation/asset_preparation.dart';
import 'package:asset_management/features/asset_preparation/presentation/components/asset_preparation_by_id_view.dart';
import 'package:asset_management/features/asset_preparation/presentation/components/asset_preparation_non_id_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/app_segmented_button.dart';
import '../../../../core/widgets/app_space.dart';

class AddAssetPreparationDetailView extends StatefulWidget {
  const AddAssetPreparationDetailView({super.key});

  @override
  State<AddAssetPreparationDetailView> createState() =>
      _AddAssetPreparationDetailViewState();
}

class _AddAssetPreparationDetailViewState
    extends State<AddAssetPreparationDetailView> {
  List<String> segmentedTypeList = ['ASSET-ID', 'NON ASSET-ID'];
  String selectedType = 'ASSET-ID';

  @override
  Widget build(BuildContext context) {
    final preparation = context.watch<AssetPreparationBloc>().state.preparation;
    return Scaffold(
      appBar: AppBar(
        title: Text(preparation!.storeName!),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 6),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.list_alt_outlined),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSegmentedButton(
                options: segmentedTypeList,
                selected: selectedType,
                onSelectionChanged: (value) => setState(() {
                  selectedType = value.first;
                }),
              ),
              AppSpace.vertical(12),
              selectedType == 'ASSET-ID'
                  ? AssetPreparationByIdView(preparation: preparation)
                  : AssetPreparationNonIdView(preparation: preparation),
            ],
          ),
        ),
      ),
    );
  }
}
