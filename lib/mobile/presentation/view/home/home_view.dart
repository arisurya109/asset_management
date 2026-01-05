// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/mobile/presentation/components/app_drawer.dart';
import 'package:asset_management/mobile/presentation/view/inventory/inventory_view.dart';
import 'package:asset_management/mobile/presentation/view/migration/migration_view.dart';
import 'package:asset_management/mobile/presentation/view/registration/registration_view.dart';
import 'package:asset_management/mobile/presentation/view/transfer/asset_transfer_view.dart';
import 'package:asset_management/mobile/responsive_layout.dart';

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
    // {'title': 'Counting', 'view': Scaffold(), 'icon': Assets.iCount},
    // {'title': 'Receive', 'view': Scaffold(), 'icon': Assets.iCount},
    // {'title': 'Return', 'view': Scaffold(), 'icon': Assets.iCount},
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
      body: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        itemCount: operations.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isLarge ? 3 : 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1 / 1,
        ),
        itemBuilder: (context, index) {
          final operation = operations[index];
          return Material(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(5),
            child: InkWell(
              onTap: () {
                context.pushExt(operation['view']);
              },
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
