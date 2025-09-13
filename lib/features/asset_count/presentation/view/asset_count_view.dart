import 'package:asset_management/core/extension/context_ext.dart';

import '../../../../core/utils/colors.dart';
import '../../../../core/utils/enum.dart';
import '../bloc/asset_count_detail/asset_count_detail_bloc.dart';
import '../bloc/asset_count/asset_count_bloc.dart';
import 'asset_count_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetCountView extends StatefulWidget {
  const AssetCountView({super.key});

  @override
  State<AssetCountView> createState() => _AssetCountViewState();
}

class _AssetCountViewState extends State<AssetCountView> {
  @override
  void initState() {
    super.initState();
    context.read<AssetCountBloc>().add(OnGetAllAssetCount());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetCountBloc, AssetCountState>(
      builder: (context, state) {
        if (state.status == StatusAssetCount.loading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.kBase),
          );
        }

        if (state.assetsCount == null || state.assetsCount!.isEmpty) {
          return Center(
            child: Text(state.message ?? 'Asset count is still empty'),
          );
        } else {
          return ListView.builder(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
            itemCount: state.assetsCount!.length,
            itemBuilder: (context, index) {
              final assetCount = state.assetsCount![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  onTap: assetCount.status == StatusCount.CREATED
                      ? () {
                          context.showDialogConfirm(
                            title: 'Start Count',
                            content: 'Do you want to start counting ?',
                            onCancelText: 'No',
                            onConfirmText: 'Ya',
                            onCancel: () => Navigator.pop(context),
                            onConfirm: () {
                              Navigator.pop(context);
                              context.read<AssetCountBloc>().add(
                                OnUpdateStatusAssetCount(
                                  assetCount.id!,
                                  StatusCount.ONPROCESS,
                                ),
                              );
                            },
                          );
                        }
                      : () {
                          context.read<AssetCountBloc>().add(
                            OnSelectedAssetCountDetail(assetCount.id!),
                          );
                          context.read<AssetCountDetailBloc>().add(
                            OnGetAllAssetCountDetailById(assetCount.id!),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssetCountDetailView(),
                            ),
                          );
                        },
                  title: Text(assetCount.title!),
                  leading: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.kBase,
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
