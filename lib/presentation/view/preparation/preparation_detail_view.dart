import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/view/preparation/data_source_preparation_detail.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreparationDetailView extends StatelessWidget {
  const PreparationDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Preparation Detail')),
      body: BlocBuilder<PreparationBloc, PreparationState>(
        builder: (context, state) {
          if (state.preparationDetails != null ||
              state.preparationDetails != []) {
            final dataSource = DataSourcePreparationDetail(
              state.preparationDetails ?? [],
              (asset, modelId, quantity) {},
            );
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  AppSpace.vertical(16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Code : ${state.preparation?.preparationCode}'),
                          AppSpace.vertical(5),
                          Text(
                            'Destination : ${state.preparation?.destination}',
                          ),
                          AppSpace.vertical(5),
                          Text('Status : ${state.preparation?.status}'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Created By : ${state.preparation?.createdBy}'),
                          AppSpace.vertical(5),
                          Text('Assigned : ${state.preparation?.assigned}'),
                          AppSpace.vertical(5),
                          Text(
                            'Total Box : ${state.preparation?.totalBox ?? ''}',
                          ),
                        ],
                      ),
                    ],
                  ),
                  AppSpace.vertical(16),
                  Expanded(
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
                              'No',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          fixedWidth: 55,
                          headingRowAlignment: MainAxisAlignment.center,
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
                          fixedWidth: 250,
                        ),
                        DataColumn2(
                          label: Center(
                            child: Text(
                              'Qty Target',
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
                              'Qty Picked',
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
                              'Status',
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
                  ),
                ],
              ),
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
