import 'asset_count_detail_list_view.dart';
import '../bloc/asset_count_detail/asset_count_detail_bloc.dart';
import '../bloc/asset_count/asset_count_bloc.dart';
import '../../domain/entities/asset_count_detail.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../../core/extension/string_ext.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/widgets/app_asset_img.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_space.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetCountDetailView extends StatefulWidget {
  const AssetCountDetailView({super.key});

  @override
  State<AssetCountDetailView> createState() => _AssetCountDetailViewState();
}

class _AssetCountDetailViewState extends State<AssetCountDetailView> {
  late TextEditingController locationC;
  late TextEditingController boxC;
  late TextEditingController assetIdC;

  @override
  void dispose() {
    assetIdC.dispose();
    locationC.dispose();
    boxC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    locationC = TextEditingController();
    boxC = TextEditingController();
    assetIdC = TextEditingController();
  }

  _onSubmit() {
    final location = locationC.value.text.trim();
    final box = boxC.value.text.trim();
    final assetId = assetIdC.value.text.trim();

    if (!assetId.isFilled()) {
      context.showSnackbar(
        'Asset ID Nothing should be empty',
        backgroundColor: Colors.red,
      );
    } else if (!location.isFilled()) {
      context.showSnackbar(
        'Location Nothing should be empty',
        backgroundColor: Colors.red,
      );
    } else {
      context.showDialogConfirm(
        title: 'Add Asset Count ?',
        content: 'Are you sure you want to add \nAsset ID : $assetId',
        onCancel: () => Navigator.pop(context),
        onCancelText: 'Cancel',
        onConfirmText: 'Add',
        onConfirm: () {
          context.read<AssetCountDetailBloc>().add(
            OnCreateAssetCountDetail(
              AssetCountDetail(
                countId: context
                    .read<AssetCountBloc>()
                    .state
                    .assetCountDetail!
                    .id,
                assetId: assetId,
                box: box,
                location: location,
              ),
            ),
          );
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AssetCountBloc, AssetCountState>(
          builder: (context, state) {
            debugPrint(state.assetCountDetail?.status.toString());
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
          AppTextField(
            title: 'Location',
            controller: locationC,
            hintText: 'Example : LD.01.01.01',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          AppSpace.vertical(16),
          AppTextField(
            title: 'Box',
            controller: boxC,
            hintText: 'Example : BOX-LD-01',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          AppSpace.vertical(16),
          AppTextField(
            title: 'Asset ID',
            controller: assetIdC,
            hintText: 'Example : AST-PRN-2501010001',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => _onSubmit(),
          ),
          AppSpace.vertical(24),
          BlocConsumer<AssetCountDetailBloc, AssetCountDetailState>(
            listener: (context, state) {
              if (state.status == StatusAssetCountDetail.failed &&
                  state.message != null) {
                context.showSnackbar(
                  state.message!,
                  backgroundColor: Colors.red,
                );
              }

              if (state.status == StatusAssetCountDetail.success &&
                  state.message != null) {
                assetIdC.clear();
                context.showSnackbar(
                  state.message!,
                  backgroundColor: AppColors.kBase,
                );
              }
            },
            builder: (context, state) {
              final statusDoc = context
                  .watch<AssetCountBloc>()
                  .state
                  .assetCountDetail
                  ?.status;
              return AppButton(
                title: state.status == StatusAssetCountDetail.loading
                    ? 'Loading...'
                    : 'Submit',
                onPressed: statusDoc != StatusCount.ONPROCESS
                    ? null
                    : state.status == StatusAssetCountDetail.loading
                    ? null
                    : _onSubmit,
              );
            },
          ),
        ],
      ),
    );
  }
}
