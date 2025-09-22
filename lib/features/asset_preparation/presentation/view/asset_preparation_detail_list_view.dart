import 'package:asset_management/core/core.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../components/data_source_preparation.dart';
import '../../asset_preparation.dart';

class AssetPreparationDetailListView extends StatefulWidget {
  const AssetPreparationDetailListView({super.key});

  @override
  State<AssetPreparationDetailListView> createState() =>
      _AssetPreparationDetailListViewState();
}

class _AssetPreparationDetailListViewState
    extends State<AssetPreparationDetailListView> {
  late TextEditingController boxC;

  @override
  void initState() {
    boxC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    boxC.dispose();
    super.dispose();
  }

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
                final preparation = context
                    .watch<AssetPreparationBloc>()
                    .state
                    .preparation;

                debugPrint(preparation.toString());
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
                            Navigator.pop(context);
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
                    minWidth: 900,
                    empty: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade100),
                      child: Center(child: Text('Not Found')),
                    ),
                    wrapInCard: false,
                    renderEmptyRowsInTheEnd: false,
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
                        fixedWidth: 50,
                      ),
                      DataColumn2(
                        label: Text(
                          'ASSET',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        fixedWidth: 200,
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                      DataColumn2(
                        label: Text(
                          'TYPE',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                        fixedWidth: 150,
                      ),
                      DataColumn2(
                        label: Text(
                          'QTY',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                        fixedWidth: 90,
                      ),
                      DataColumn2(
                        label: Text(
                          'LOCATION',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                        fixedWidth: 150,
                      ),
                      DataColumn2(
                        label: Text(
                          'BOX',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                        fixedWidth: 150,
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
              listener: (context, state) async {
                if (state.status == StatusPreparation.updated) {
                  context.showSnackbar('Preparation Completed');
                  context.read<AssetPreparationBloc>().add(
                    OnFindPreparationById(state.preparation!.id!),
                  );
                }
                if (state.status == StatusPreparation.exported) {
                  context.showSnackbar('Exported completed');
                  Future.delayed(Duration(seconds: 5));
                  await OpenFile.open(state.message);
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
                    onPressed: state.status == StatusPreparation.loading
                        ? null
                        : preparation.status == PreparationStatus.inprogress
                        ? () => _completed(preparation)
                        : () => context.read<AssetPreparationBloc>().add(
                            OnExportPreparation(preparation.id!),
                          ),
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

  _submit(int preparationId) {
    final box = boxC.value.text.trim();

    if (!box.isFilled() && box.isNumber()) {
      Navigator.pop(context);
      context.showSnackbar('The total box must not be empty');
    } else {
      Navigator.pop(context);
      context.read<AssetPreparationBloc>().add(
        OnUpdateStatusPreparaion(
          AssetPreparation(
            status: PreparationStatus.completed,
            totalBox: int.tryParse(box),
            updatedAt: DateTime.now().toIso8601String(),
            id: preparationId,
          ),
        ),
      );
    }
  }

  _completed(AssetPreparation preparation) {
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
                controller: boxC,
                onSubmitted: (_) => _submit(preparation.id!),
              ),
              AppSpace.vertical(48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    title: 'Submit',
                    onPressed: () => _submit(preparation.id!),
                  ),
                  AppButton(
                    title: 'Cancel',
                    onPressed: () => Navigator.pop(context),
                  ),
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
