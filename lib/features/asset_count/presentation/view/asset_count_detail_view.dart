import 'package:asset_management/features/asset_count/presentation/components/asset_count_by_asset_id_view.dart';

import '../../../../core/widgets/app_segmented_button.dart';
import '../components/asset_count_non_asset_id_view.dart';
import 'asset_count_detail_list_view.dart';
import '../bloc/asset_count/asset_count_bloc.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/widgets/app_asset_img.dart';
import '../../../../core/widgets/app_space.dart';
import '../../../../core/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetCountDetailView extends StatefulWidget {
  const AssetCountDetailView({super.key});

  @override
  State<AssetCountDetailView> createState() => _AssetCountDetailViewState();
}

class _AssetCountDetailViewState extends State<AssetCountDetailView> {
  List<String> segmentedTypeList = ['ASSET-ID', 'NON ASSET-ID'];
  String selectedType = 'ASSET-ID';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AssetCountBloc, AssetCountState>(
          builder: (context, state) {
            return Text(state.assetCountDetail!.title!);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssetCountDetailListView(),
                ),
              ),
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              splashColor: Colors.transparent,
              child: AppAssetImg(Assets.iList, color: AppColors.kBase),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
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
              ? AssetCountByAssetIdView()
              : AssetCountNonAssetIdView(),
        ],
      ),
    );
  }
}
