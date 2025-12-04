// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/bloc/picking/picking_bloc.dart';
import 'package:asset_management/presentation/view/picking/picking_view.dart';
import 'package:flutter/material.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/components/app_drawer.dart';
import 'package:asset_management/presentation/view/inventory/inventory_view.dart';
import 'package:asset_management/presentation/view/migration/migration_view.dart';
import 'package:asset_management/presentation/view/registration/registration_view.dart';
import 'package:asset_management/presentation/view/transfer/asset_transfer_view.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List operations = [
    {
      'title': 'Registration',
      'view': RegistrationView(),
      'icon': Assets.iAssetRegistration,
    },
    {
      'title': 'Migration',
      'view': MigrationView(),
      'icon': Assets.iAssetMigration,
    },
    {
      'title': 'Inventory',
      'view': InventoryView(),
      'icon': Assets.iAssetManagement,
    },
    {'title': 'Transfer', 'view': TransferView(), 'icon': Assets.iTransfer},
    {'title': 'Picking', 'view': PickingView(), 'icon': Assets.iPicking},
    {'title': 'Counting', 'view': Scaffold(), 'icon': Assets.iCount},
    {'title': 'Receive', 'view': Scaffold(), 'icon': Assets.iCount},
    {'title': 'Return', 'view': Scaffold(), 'icon': Assets.iCount},
  ];

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileHome(),
      mobileMScaffold: _mobileHome(isLarge: false),
    );
  }

  Widget _mobileHome({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Asset Management')),
      drawer: AppDrawer(isLarge: isLarge),
      body: SingleChildScrollView(
        child: BlocBuilder<AssetBloc, AssetState>(
          builder: (context, state) {
            final totalQuantity = state.assets?.fold<int>(
              0,
              (previousValue, asset) => previousValue + (asset.quantity ?? 0),
            );

            final assets = state.assets;
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: BlocBuilder<MasterBloc, MasterState>(
                builder: (context, state) {
                  List dashboard = [
                    {
                      'title': 'Model',
                      'icon': Assets.iAssetModel,
                      'value': state.models?.length.toString(),
                    },
                    {
                      'title': 'Category',
                      'icon': Assets.iAssetCategory,
                      'value': state.categories?.length.toString(),
                    },
                    {
                      'title': 'Location',
                      'icon': Assets.iLocation,
                      'value': state.locations?.length.toString(),
                    },
                    {
                      'title': 'Brand',
                      'icon': Assets.iAssetBrand,
                      'value': state.brands?.length.toString(),
                    },
                    {
                      'title': 'Quantity',
                      'icon': Assets.iAssetMaster,
                      'value': totalQuantity.toString(),
                    },
                    {
                      'title': 'Assets',
                      'icon': Assets.iAssetMaster,
                      'value': assets?.length.toString(),
                    },
                  ];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppDashboardContent(
                        dashboard: dashboard,
                        isLarge: isLarge,
                      ),
                      AppSpace.vertical(16),
                      Text(
                        'Operations',
                        style: TextStyle(
                          fontSize: isLarge ? 16 : 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      AppSpace.vertical(16),
                      GridView.builder(
                        itemCount: operations.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isLarge ? 3 : 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1 / 1,
                        ),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final operation = operations[index];
                          return Material(
                            color: AppColors.kWhite,
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              onTap: () {
                                if (operation['title'] == 'Picking') {
                                  context.read<PickingBloc>().add(
                                    OnFindAllPickingTask(
                                      context
                                          .read<AuthenticationBloc>()
                                          .state
                                          .user!
                                          .id!,
                                    ),
                                  );
                                }
                                context.push(operation['view']);
                              },
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AppAssetImg(
                                      operation['icon'],
                                      color: AppColors.kBase,
                                      height: isLarge ? 26 : 22,
                                      width: isLarge ? 26 : 22,
                                    ),
                                    Text(
                                      operation['title'],
                                      style: TextStyle(
                                        fontSize: isLarge ? 12 : 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      AppSpace.vertical(24),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class AppDashboardContent extends StatelessWidget {
  final List dashboard;
  final bool isLarge;

  const AppDashboardContent({
    super.key,
    required this.dashboard,
    this.isLarge = true,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: dashboard.length,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        mainAxisExtent: 70,
      ),
      itemBuilder: (context, index) {
        final item = dashboard[index];
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: index % 4 == 0
                  ? AppColors.kBase
                  : index == 3
                  ? AppColors.kBase
                  : AppColors.kGrey,
            ),
            color: index % 4 == 0
                ? AppColors.kWhite
                : index == 3
                ? AppColors.kWhite
                : AppColors.kBase,
          ),

          child: Row(
            children: [
              if (isLarge)
                AppAssetImg(
                  item['icon'],
                  height: 28,
                  width: 28,
                  color: index % 4 == 0
                      ? AppColors.kBase
                      : index == 3
                      ? AppColors.kBase
                      : AppColors.kWhite,
                ),
              AppSpace.horizontal(8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['title'] ?? '',
                      style: TextStyle(
                        fontSize: isLarge ? 16 : 14,
                        fontWeight: FontWeight.w500,
                        color: index % 4 == 0
                            ? AppColors.kBase
                            : index == 3
                            ? AppColors.kBase
                            : AppColors.kWhite,
                      ),
                    ),
                    AppSpace.vertical(5),
                    Text(
                      item['value'] ?? '',
                      style: TextStyle(
                        fontSize: isLarge ? 16 : 14,
                        fontWeight: FontWeight.w600,
                        color: index % 4 == 0
                            ? AppColors.kBase
                            : index == 3
                            ? AppColors.kBase
                            : AppColors.kWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
