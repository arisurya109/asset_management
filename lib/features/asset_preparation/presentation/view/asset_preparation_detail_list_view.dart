import 'package:asset_management/core/widgets/app_text_field.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/app_button.dart';
import '../components/data_source_preparation.dart';
import '../../asset_preparation.dart';
import '../../../../core/extension/context_ext.dart';
import '../../../../core/widgets/app_space.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constant.dart';

class AssetPreparationDetailListView extends StatefulWidget {
  const AssetPreparationDetailListView({super.key});

  @override
  State<AssetPreparationDetailListView> createState() =>
      _AssetPreparationDetailListViewState();
}

class _AssetPreparationDetailListViewState
    extends State<AssetPreparationDetailListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail List Preparation'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.fromLTRB(16, 12, 16, 0),
        child: Column(
          children: [
            BlocBuilder<AssetPreparationBloc, AssetPreparationState>(
              builder: (context, state) {
                final preparation = state.preparation;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name : ${preparation!.storeName!}'),
                        AppSpace.vertical(3),
                        Text('Initial : ${preparation.storeInitial!}'),
                        AppSpace.vertical(3),
                        Text('Code : ${preparation.storeCode!}'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Status : ${preparation.status!}'),
                        AppSpace.vertical(3),
                        Text('Type : ${preparation.type!}'),
                        AppSpace.vertical(3),
                        Text(
                          'Created : ${DateFormat('d-MM-y').format(DateTime.parse(preparation.createdAt!))}',
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),

            AppSpace.vertical(16),

            BlocBuilder<
              AssetPreparationDetailBloc,
              AssetPreparationDetailState
            >(
              builder: (context, state) {
                debugPrint(state.status.toString());

                final preparationDoc = context
                    .watch<AssetPreparationBloc>()
                    .state
                    .preparation;
                final dataSource = DataSourcePreparation(
                  state.preparations ?? [],
                  (asset, type, quantity, location, box) =>
                      preparationDoc!.status == PreparationStatus.completed
                      ? null
                      : context.showDialogConfirm(
                          title: 'Delete Asset ?',
                          content:
                              'Asset ID: $asset\nType : $type\nQuantity : $quantity\nBox : $location\nCondition : $box',
                          onCancel: () => Navigator.pop(context),
                          onCancelText: 'Cancel',
                          onConfirmText: 'Yes',
                          onConfirm: () {
                            context.read<AssetPreparationDetailBloc>().add(
                              OnDeletedPreparationDetails(
                                preparationDoc.id!,
                                asset,
                              ),
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
                        fixedWidth: 220,
                      ),
                      DataColumn2(
                        label: Center(
                          child: Text(
                            'TYPE',
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
                        fixedWidth: 120,
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
                        fixedWidth: 170,
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
                        fixedWidth: 170,
                      ),
                    ],
                    source: dataSource,
                  ),
                );
              },
            ),

            BlocConsumer<AssetPreparationBloc, AssetPreparationState>(
              listenWhen: (previous, current) {
                if (previous.status != current.status) {
                  return true;
                } else {
                  return false;
                }
              },
              listener: (context, state) {
                if (state.status == StatusPreparation.updated) {
                  context.showSnackbar('Preparation Completed');
                }
                if (state.status == StatusPreparation.exported) {
                  context.showSnackbar('Exported completed');
                }
              },
              builder: (context, state) {
                final preparation = context
                    .watch<AssetPreparationBloc>()
                    .state
                    .preparation!;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppButton(
                    title: state.status == StatusPreparation.loading
                        ? 'Loading...'
                        : preparation.status == PreparationStatus.inprogress
                        ? 'Completed'
                        : 'Exported',
                    onPressed: () => _completed(preparation),
                    width: double.maxFinite,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _completed(AssetPreparation preparation) {
    // context.showDialogOption(
    //   title: 'Completed Preparation',
    //   children: [
    //     AppSpace.vertical(24),
    //     AppTextField(title: 'Total Box'),
    //     AppSpace.vertical(24),
    //     AppButton(title: 'Submit', onPressed: () {}),
    //   ],
    // );
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSpace.vertical(16),

              Text(
                'Completed Preparation ?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              AppSpace.vertical(24),
              AppTextField(
                title: 'Total Box',
                textInputAction: TextInputAction.go,
                hintText: 'Example : 24',
                keyboardType: TextInputType.number,
              ),
              AppSpace.vertical(48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(title: 'Submit'),
                  AppButton(title: 'Cancel'),
                ],
              ),
              AppSpace.vertical(24),
            ],
          ),
        );
      },
    );
  }
}
