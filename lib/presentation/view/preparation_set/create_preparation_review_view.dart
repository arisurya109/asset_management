import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/preparation_template.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/view/home/home_view.dart';
import 'package:asset_management/presentation/view/preparation_set/data_source_preparation_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CreatePreparationReviewView extends StatefulWidget {
  final PreparationTemplate params;

  const CreatePreparationReviewView({super.key, required this.params});

  @override
  State<CreatePreparationReviewView> createState() =>
      CreatePreparationReviewViewState();
}

class CreatePreparationReviewViewState
    extends State<CreatePreparationReviewView> {
  late DataSource dataSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Review Preparation Set')),
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
            context.showSnackbar('Successfully create prepartion set');
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(12),
            child: AppButton(
              title: 'Create',
              onPressed: () => context.showDialogConfirm(
                title: 'Create Preparation Set',
                content: 'Are you sure create preparation set ?',
                onCancel: () => context.pop(),
                onCancelText: 'Cancel',
                onConfirmText: 'Yes',
                onConfirm: () {
                  context.read<MasterBloc>().add(
                    OnCreatePreparationTemplateItemEvent(
                      widget.params.items!,
                      widget.params,
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
          final dataSource = DataSource(
            widget.params.items ?? [],
            (asset, modelId, quantity) => context.showDialogConfirm(
              title: 'Delete Asset ?',
              content: 'Asset : $asset\nQuantity : $quantity',
              onCancel: () => context.pop(),
              onCancelText: 'Cancel',
              onConfirmText: 'Yes',
              onConfirm: () => setState(() {
                widget.params.items?.removeWhere(
                  (element) => element.modelId == modelId,
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
                    Text('Name : ${widget.params.name}'),
                    AppSpace.vertical(5),
                    Text('Description : ${widget.params.description}'),
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
                        fixedWidth: 45,
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
                        fixedWidth: 50,
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
