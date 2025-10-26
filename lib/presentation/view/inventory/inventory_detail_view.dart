import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/presentation/bloc/printer/printer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

class InventoryDetailView extends StatelessWidget {
  final AssetEntity params;

  const InventoryDetailView({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Detail'),
        actions: params.assetCode != null
            ? [
                BlocListener<PrinterBloc, PrinterState>(
                  listener: (context, state) {
                    if (state.status == PrinterStatus.success) {
                      context.showSnackbar('Success reprint asset code');
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
            _descriptionItem('Asset Code', params.assetCode ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Serial Number', params.serialNumber ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Type', params.types ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Category', params.category ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Brand', params.brand ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Model', params.model ?? ''),
            AppSpace.vertical(18),
            _descriptionItem(
              'Quantity',
              params.uom == 1
                  ? '${params.quantity} Unit'
                  : '${params.quantity} Pcs',
            ),
            AppSpace.vertical(18),
            _descriptionItem('Color', params.color ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Condition', params.conditions ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Status', params.status ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Location', params.location ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Purchase Order', params.purchaseOrder ?? '-'),
            AppSpace.vertical(18),
            _descriptionItem('Notes', params.remarks ?? '-'),
            AppSpace.vertical(18),
          ],
        ),
      ),
    );
  }

  Widget _descriptionItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        AppSpace.vertical(3),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
