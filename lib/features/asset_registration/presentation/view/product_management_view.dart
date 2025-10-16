import 'package:asset_management/features/asset_registration/domain/entities/asset_registration.dart';
import 'package:asset_management/features/asset_registration/presentation/view/data_source_inventory.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../bloc/asset_registration/asset_registration_bloc.dart';

class ProductManagementView extends StatefulWidget {
  const ProductManagementView({super.key});

  @override
  State<ProductManagementView> createState() => _ProductManagementViewState();
}

class _ProductManagementViewState extends State<ProductManagementView> {
  @override
  void initState() {
    context.read<AssetRegistrationBloc>().add(OnFindAllAssetRegistration());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('INVENTORY'),
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<AssetRegistrationBloc, AssetRegistrationState>(
          builder: (context, state) {
            if (state.status == StatusAssetRegistration.failed) {
              return Center(child: Text(state.message ?? ''));
            }

            if (state.assetNonConsumable == null &&
                state.assetsConsumable == null) {
              return Center(child: Text('Asset still empty'));
            }

            List<AssetRegistration> datas = state.assetNonConsumable ?? [];

            final dataSource = DataSourceInventory(
              datas,
              (assetId, type, quantity, location, box) {},
            );

            // return Container();

            return Column(
              children: [
                AppSpace.vertical(12),
                Expanded(
                  child: PaginatedDataTable2(
                    minWidth: 2000,
                    empty: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade100),
                      child: Center(child: Text('Not Found')),
                    ),
                    wrapInCard: false,
                    renderEmptyRowsInTheEnd: false,
                    border: TableBorder.all(),
                    headingRowDecoration: BoxDecoration(color: Colors.teal),
                    source: dataSource,
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
                        fixedWidth: 200,
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
                        fixedWidth: 200,
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
                          'AREA',
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
                          'REMARKS',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        headingRowAlignment: MainAxisAlignment.center,
                        fixedWidth: 200,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
