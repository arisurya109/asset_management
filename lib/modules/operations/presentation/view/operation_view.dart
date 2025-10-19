import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/inventory/presentation/inventory_view.dart';
import 'package:asset_management/features/migration/migration_export.dart';
import 'package:asset_management/features/preparation/presentation/view/preparation_view.dart';
import 'package:asset_management/features/registration/registration_export.dart';
import 'package:asset_management/features/transfer/transfer_export.dart';
import 'package:flutter/material.dart';

class OperationView extends StatelessWidget {
  const OperationView({super.key});

  @override
  Widget build(BuildContext context) {
    List operations = [
      {
        'title': 'Registration',
        'icon': Assets.iAssetRegistration,
        'view': RegistrationView(),
      },
      {
        'title': 'Migration',
        'icon': Assets.iAssetMigration,
        'view': MigrationView(),
      },
      {'title': 'Transfer', 'icon': Assets.iTransfer, 'view': TransferView()},
      {
        'title': 'Inventory',
        'icon': Assets.iAssetManagement,
        'view': InventoryView(),
      },
      {
        'title': 'Preparation',
        'icon': Assets.iPreparation,
        'view': PreparationView(),
      },
      {'title': 'Counting', 'icon': Assets.iCount},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppSpace.vertical(MediaQuery.of(context).viewPadding.top + 5),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: operations.length,
              itemBuilder: (context, index) {
                final operation = operations[index];
                return ListTile(
                  onTap: () => context.push(operation['view']),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  title: Text(
                    operation['title'],
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: AppAssetImg(
                      operation['icon'],
                      height: 28,
                      width: 28,
                      color: AppColors.kBlack,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
