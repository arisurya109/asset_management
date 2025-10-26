// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/presentation/components/app_dashboard_content.dart';
import 'package:asset_management/presentation/components/app_drawer.dart';
import 'package:asset_management/presentation/view/inventory/inventory_view.dart';
import 'package:asset_management/presentation/view/migration/migration_view.dart';
import 'package:asset_management/presentation/view/registration/registration_view.dart';
import 'package:asset_management/presentation/view/transfer/asset_transfer_view.dart';
import 'package:flutter/material.dart';

import 'package:asset_management/core/core.dart';

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
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Asset Management')),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppDashboardContent(),
              AppSpace.vertical(24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Operations',
                    style: TextStyle(
                      color: AppColors.kBlack,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppSpace.vertical(12),
                  GridView.builder(
                    itemCount: operations.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemBuilder: (context, index) {
                      final operation = operations[index];
                      return Column(
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(32),
                            color: AppColors.kWhite,
                            child: InkWell(
                              onTap: () => context.push(operation['view']),
                              borderRadius: BorderRadius.circular(32),
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.kBase),
                                ),
                                child: AppAssetImg(
                                  operation['icon'],
                                  height: 32,
                                  width: 32,
                                  color: AppColors.kBase,
                                ),
                              ),
                            ),
                          ),
                          AppSpace.vertical(5),
                          Text(
                            operation['title'],
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
