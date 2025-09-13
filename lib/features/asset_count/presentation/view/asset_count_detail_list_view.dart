import 'package:asset_management/core/widgets/app_button.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart' as of;

import '../../../../core/utils/enum.dart';
import '../components/data_source.dart';
import '../bloc/asset_count/asset_count_bloc.dart';
import '../bloc/asset_count_detail/asset_count_detail_bloc.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../../core/widgets/app_space.dart';
import '../../../../core/utils/colors.dart';

class AssetCountDetailListView extends StatefulWidget {
  const AssetCountDetailListView({super.key});

  @override
  State<AssetCountDetailListView> createState() =>
      _AssetCountDetailListViewState();
}

class _AssetCountDetailListViewState extends State<AssetCountDetailListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<AssetCountBloc, AssetCountState>(
          builder: (context, state) {
            return Text('${state.assetCountDetail!.title!} Detail');
          },
        ),
        // actions: [
        //   BlocConsumer<AssetCountBloc, AssetCountState>(
        //     listener: (context, state) {
        //       if (state.status == StatusAssetCount.failed) {
        //         context.showSnackbar(
        //           state.message!,
        //           backgroundColor: Colors.red,
        //         );
        //       }

        //       if (state.status == StatusAssetCount.success) {
        //         context.showDialogConfirm(
        //           title: 'Successfully Exported',
        //           content: '${state.message}, Open this file ?',
        //           onCancelText: 'No',
        //           onConfirmText: 'Yes',
        //           onCancel: () => Navigator.pop(context),
        //           onConfirm: () async => await of.OpenFile.open(state.message),
        //         );
        //       }
        //     },
        //     builder: (context, state) {
        //       return Padding(
        //         padding: const EdgeInsets.only(right: 24),
        //         child: InkWell(
        //           onTap: () => context.read<AssetCountBloc>().add(
        //             OnExportAssetCount(state.assetCountDetail!.id!),
        //           ),
        //           overlayColor: WidgetStatePropertyAll(Colors.transparent),
        //           splashColor: Colors.transparent,
        //           child: AppAssetImg(
        //             Assets.iExport,
        //             color: AppColors.kBase,
        //             height: 24,
        //             width: 24,
        //           ),
        //         ),
        //       );
        //     },
        //   ),
        // ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            BlocBuilder<AssetCountBloc, AssetCountState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  // direction: Axis.vertical,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Code : ${state.assetCountDetail?.countCode}'),

                        Text(
                          'Status : ${state.assetCountDetail?.status == StatusCount.CREATED
                              ? 'CREATED'
                              : state.assetCountDetail?.status == StatusCount.ONPROCESS
                              ? 'ON PROCESS'
                              : 'COMPLETED'}',
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date : ${DateFormat('d-MMMM-y').format(state.assetCountDetail!.countDate!)}',
                        ),
                        Text(
                          'Time : ${DateFormat('HH:mm').format(state.assetCountDetail!.countDate!)}',
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),

            AppSpace.vertical(16),

            // Table Asset
            BlocBuilder<AssetCountDetailBloc, AssetCountDetailState>(
              builder: (context, state) {
                final assets = context
                    .watch<AssetCountDetailBloc>()
                    .state
                    .assets;

                var assetCount = context
                    .watch<AssetCountBloc>()
                    .state
                    .assetCountDetail;

                final dataSource = DataSource(
                  assets ?? [],
                  (asset, name, location, box, condition) =>
                      assetCount?.status == StatusCount.COMPLETED
                      ? null
                      : context.showDialogConfirm(
                          title: 'Delete Asset ?',
                          content:
                              'Asset ID: $asset\nAsset Name : $name\nLocation : $location\nBox : $box\nCondition : $condition',
                          onCancel: () => Navigator.pop(context),
                          onCancelText: 'Cancel',
                          onConfirmText: 'Yes',
                          onConfirm: () {
                            context.read<AssetCountDetailBloc>().add(
                              OnDeleteAssetCountDetail(assetCount!.id!, asset),
                            );
                          },
                        ),
                );
                return Expanded(
                  child: PaginatedDataTable2(
                    minWidth: 1100,
                    empty: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade100),
                      child: Center(child: Text('Not Found')),
                    ),
                    renderEmptyRowsInTheEnd: false,
                    rowsPerPage: 10,
                    wrapInCard: false,
                    border: TableBorder.all(),
                    headingRowDecoration: BoxDecoration(color: Colors.teal),
                    columns: [
                      DataColumn2(
                        label: Center(
                          child: Text(
                            'NO',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        fixedWidth: 45,
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                      DataColumn2(
                        label: Center(
                          child: Text(
                            'ASSET ID',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        fixedWidth: 200,
                      ),
                      DataColumn2(
                        label: Center(
                          child: Text(
                            'ASSET NAME',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        fixedWidth: 200,
                      ),
                      DataColumn2(
                        label: Center(
                          child: Text(
                            'LOCATION',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        fixedWidth: 200,
                      ),
                      DataColumn2(
                        label: Center(
                          child: Text(
                            'BOX',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        fixedWidth: 200,
                      ),
                      DataColumn2(
                        label: Center(
                          child: Text(
                            'CONDITION',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        fixedWidth: 200,
                      ),
                    ],
                    source: dataSource,
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: BlocConsumer<AssetCountBloc, AssetCountState>(
                listener: (context, state) async {
                  if (state.status == StatusAssetCount.failed &&
                      state.message != null) {
                    context.showSnackbar(state.message!);
                  }
                  if (state.status == StatusAssetCount.success &&
                      state.message != null) {
                    context.showSnackbar(
                      'Successfully Exported : ${state.message}',
                    );

                    await of.OpenFile.open(state.message);
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.assetCountDetail?.status == StatusCount.CREATED
                        ? 'START'
                        : state.assetCountDetail?.status ==
                              StatusCount.ONPROCESS
                        ? 'COMPLETED'
                        : 'EXPORT',
                    onPressed:
                        state.assetCountDetail?.status == StatusCount.COMPLETED
                        ? () => context.read<AssetCountBloc>().add(
                            OnExportAssetCount(state.assetCountDetail!.id!),
                          )
                        : () => context.read<AssetCountBloc>().add(
                            OnUpdateStatusAssetCount(
                              state.assetCountDetail!.id!,
                              StatusCount.COMPLETED,
                            ),
                          ),
                    width: double.maxFinite,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
