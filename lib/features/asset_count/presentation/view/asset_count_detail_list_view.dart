import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart' as of;

import '../components/data_source.dart';
import '../bloc/asset_count/asset_count_bloc.dart';
import '../bloc/asset_count_detail/asset_count_detail_bloc.dart';
import '../../../../core/core.dart';

class AssetCountDetailListView extends StatefulWidget {
  const AssetCountDetailListView({super.key});

  @override
  State<AssetCountDetailListView> createState() =>
      _AssetCountDetailListViewState();
}

class _AssetCountDetailListViewState extends State<AssetCountDetailListView> {
  @override
  Widget build(BuildContext context) {
    final title = context.watch<AssetCountBloc>().state.assetCountDetail!.title;
    return AppScaffold(
      title: '${title?.toUpperCase()} DETAIL',
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

                debugPrint(assets.toString());

                final dataSource = DataSource(
                  assets ?? [],
                  (asset, name, location, box, condition, quantity) =>
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
                            Navigator.pop(context);
                            context.read<AssetCountDetailBloc>().add(
                              OnDeleteAssetCountDetail(assetCount!.id!, asset),
                            );
                          },
                        ),
                );
                return Expanded(
                  child: PaginatedDataTable2(
                    minWidth: 1200,
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
                            'ASSET',
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
                        fixedWidth: 150,
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
                        fixedWidth: 150,
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
                        fixedWidth: 170,
                      ),
                      DataColumn2(
                        label: Center(
                          child: Text(
                            'QUANTITY',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        fixedWidth: 100,
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
                  } else if (state.status == StatusAssetCount.updated) {
                    context.showSnackbar(
                      'Asset Counting Completed : ${state.message}',
                    );

                    await of.OpenFile.open(state.message);
                  } else if (state.status == StatusAssetCount.exported) {
                    context.showSnackbar(
                      'Successfully Exported : ${state.assetCountDetail!.title}',
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
