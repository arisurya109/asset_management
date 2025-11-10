import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

class InventoryDetailView extends StatelessWidget {
  final AssetEntity params;

  const InventoryDetailView({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _inventoryDetail(context),
      mobileMScaffold: _inventoryDetail(context, isLarge: false),
    );
  }

  Scaffold _inventoryDetail(BuildContext context, {bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Detail'),
        actions: params.assetCode != null
            ? [
                BlocListener<PrinterBloc, PrinterState>(
                  listener: (context, state) {
                    if (state.status == PrinterStatus.success) {
                      context.showSnackbar(
                        'Success reprint asset code',
                        fontSize: isLarge ? 14 : 12,
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: InkWell(
                      onTap: () => context.read<PrinterBloc>().add(
                        OnPrintAssetId(params.assetCode!),
                      ),
                      borderRadius: BorderRadius.circular(32),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: AppAssetImg(
                          Assets.iReprint,
                          color: AppColors.kBase,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            AppSpace.vertical(12),
            _descriptionItem(
              'Asset Code',
              params.assetCode ?? '',
              isLarge: isLarge,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Serial Number',
              params.serialNumber ?? '',
              isLarge: isLarge,
            ),
            AppSpace.vertical(18),
            _descriptionItem('Type', params.types ?? '', isLarge: isLarge),
            AppSpace.vertical(18),
            _descriptionItem(
              'Category',
              params.category ?? '',
              isLarge: isLarge,
            ),
            AppSpace.vertical(18),
            _descriptionItem('Brand', params.brand ?? '', isLarge: isLarge),
            AppSpace.vertical(18),
            _descriptionItem('Model', params.model ?? '', isLarge: isLarge),
            AppSpace.vertical(18),
            _descriptionItem(
              'Quantity',
              params.uom == 1
                  ? '${params.quantity} Unit'
                  : '${params.quantity} Pcs',
              isLarge: isLarge,
            ),
            AppSpace.vertical(18),
            _descriptionItem('Color', params.color ?? '', isLarge: isLarge),
            AppSpace.vertical(18),
            _descriptionItem(
              'Condition',
              params.conditions ?? '',
              isLarge: isLarge,
            ),
            AppSpace.vertical(18),
            _descriptionItem('Status', params.status ?? '', isLarge: isLarge),
            AppSpace.vertical(18),
            _descriptionItem(
              'Location',
              params.location ?? '',
              isLarge: isLarge,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Purchase Order',
              params.purchaseOrder ?? '-',
              isLarge: isLarge,
            ),
            AppSpace.vertical(18),
            _descriptionItem('Notes', params.remarks ?? '-', isLarge: isLarge),
            AppSpace.vertical(18),
          ],
        ),
      ),
    );
  }

  Widget _descriptionItem(String title, String value, {bool isLarge = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppSpace.vertical(3),
        Text(
          value,
          style: TextStyle(
            fontSize: isLarge ? 14 : 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
