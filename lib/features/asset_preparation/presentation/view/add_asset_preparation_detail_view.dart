import 'asset_preparation_detail_list_view.dart';
import '../components/asset_preparation_by_id_view.dart';
import '../components/asset_preparation_non_id_view.dart';
import '../../asset_preparation.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/app_segmented_button.dart';
import '../../../../core/widgets/app_space.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title:
            BlocSelector<AssetPreparationBloc, AssetPreparationState, String?>(
              selector: (state) {
                return state.preparation?.storeName;
              },
              builder: (context, state) {
                if (state != null) {
                  return Text(state);
                }
                return Text('');
              },
            ),
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
              onPressed: () {
                final preparationId = context
                    .read<AssetPreparationBloc>()
                    .state
                    .preparation!
                    .id;
                context.read<AssetPreparationDetailBloc>().add(
                  OnFindAllPreparationDetails(preparationId!),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssetPreparationDetailListView(),
                  ),
                );
              },
              icon: Icon(Icons.list_alt_outlined),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child:
              BlocSelector<
                AssetPreparationBloc,
                AssetPreparationState,
                AssetPreparation
              >(
                selector: (state) {
                  return state.preparation!;
                },
                builder: (context, state) {
                  return Column(
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
                          ? AssetPreparationByIdView(preparation: state)
                          : AssetPreparationNonIdView(preparation: state),
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }
}
