import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/view/home/home_view.dart';
import 'package:asset_management/presentation/view/preparation/data_source_preparation.dart';
import 'package:asset_management/presentation/view/preparation_set/data_source_preparation_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CreatePreparationReviewDetailView extends StatefulWidget {
  final Preparation params;
  final List<PreparationDetail> preparationDetail;

  const CreatePreparationReviewDetailView({
    super.key,
    required this.params,
    required this.preparationDetail,
  });

  @override
  State<CreatePreparationReviewDetailView> createState() =>
      CreatePreparationReviewDetailViewState();
}

class CreatePreparationReviewDetailViewState
    extends State<CreatePreparationReviewDetailView> {
  late DataSource dataSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Preparation')),
      bottomNavigationBar: BlocConsumer<MasterBloc, MasterState>(
        listener: (context, state) {
          if (state.status == StatusMaster.failed) {
            context.showSnackbar(
              state.message ?? 'Failed to create preparation',
              backgroundColor: AppColors.kRed,
            );
          }
          if (state.status == StatusMaster.success) {
            context.pushReplacment(HomeView());
            context.showSnackbar('Successfully create preparation');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(12),
            child: AppButton(
              title: 'Create',
              onPressed: () => context.showDialogConfirm(
                title: 'Create Preparation',
                content: 'Are you sure create preparation ?',
                onCancel: () => context.pop(),
                onCancelText: 'Cancel',
                onConfirmText: 'Yes',
                onConfirm: () {
                  context.read<PreparationBloc>().add(
                    OnCreatePreparationEvent(
                      widget.params,
                      widget.preparationDetail,
                    ),
                  );
                  context.pop();
                },
              ),
            ),
          );
        },
      ),
      body: BlocBuilder<MasterBloc, MasterState>(
        builder: (context, state) {
          final dataSource = DataSourcePreparation(
            widget.preparationDetail,
            (asset, modelId, quantity) => context.showDialogConfirm(
              title: 'Delete Asset ?',
              content: 'Asset : $asset\nQuantity : $quantity',
              onCancel: () => context.pop(),
              onCancelText: 'Cancel',
              onConfirmText: 'Yes',
              onConfirm: () => setState(() {
                widget.preparationDetail.removeWhere(
                  (element) => element.assetModelId == modelId,
                );
                context.pop();
              }),
            ),
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Destination : ${widget.params.destination}'),
                    AppSpace.vertical(5),
                    Text('Assigned : ${widget.params.assigned}'),
                  ],
                ),
              ),
              AppSpace.vertical(5),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: PaginatedDataTable2(
                    minWidth: 2000,
                    empty: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade100),
                      child: Center(child: Text('Not Found')),
                    ),
                    renderEmptyRowsInTheEnd: false,
                    rowsPerPage: 10,
                    wrapInCard: false,
                    border: TableBorder.all(),
                    headingRowDecoration: BoxDecoration(color: Colors.teal),
                    columns: const [
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
                        fixedWidth: 70,
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                      DataColumn2(
                        label: Center(
                          child: Text(
                            'Type',
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
                            'Brand',
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
                            'Category',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        fixedWidth: 250,
                      ),
                      DataColumn2(
                        label: Center(
                          child: Text(
                            'Model',
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
                            'QTY',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        fixedWidth: 70,
                      ),
                    ],
                    source: dataSource,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
