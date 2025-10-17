import 'package:asset_management/features/modules/inventories/inventory_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';

class InventoryDetailView extends StatelessWidget {
  final Inventory params;

  const InventoryDetailView({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Detail'),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(height: 1, color: AppColors.kBase),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: AppButton(
          title: 'Reprint',
          onPressed: params.assetCode == null || params.assetCode!.isEmpty
              ? null
              : () => context.read<InventoryBloc>().add(
                  OnReprintAsset(params.assetCode!),
                ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Asset Code'),
                      Text('Serial Number'),
                      Text('Location'),
                      Text('Status'),
                      Text('Condition'),
                      Text('Uom'),
                      Text('Quantity'),
                      Text('Model'),
                      Text('Brand'),
                      Text('Category'),
                      Text('Type'),
                      Text('Color'),
                      Text('Purchase Order'),
                      Text('Remarks'),
                    ],
                  ),
                  Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                      Text('  :   '),
                    ],
                  ),
                  Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(params.assetCode ?? ''),
                      Text(params.serialNumber ?? ''),
                      Text(params.location ?? ''),
                      Text(params.status ?? ''),
                      Text(params.conditions ?? ''),
                      Text(params.uom == 1 ? 'Unit' : 'Pcs'),
                      Text(params.quantity.toString()),
                      Text(params.model ?? ''),
                      Text(params.brand ?? ''),
                      Text(params.category ?? ''),
                      Text(params.types ?? ''),
                      Text(params.color ?? ''),
                      Text(params.purchaseOrder ?? ''),
                      Text(params.remarks ?? ''),
                    ],
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
