import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/printer/presentation/bloc/printer/printer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/core.dart';

class AssetsDetailView extends StatelessWidget {
  final AssetsEntity params;

  const AssetsDetailView({super.key, required this.params});

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
            _descriptionItem('Color', params.color ?? ''),
            AppSpace.vertical(18),
            _descriptionItem(
              'Quantity',
              params.uom == 1
                  ? '${params.quantity} Unit'
                  : '${params.quantity} Pcs',
            ),
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
            BlocBuilder<AssetDetailBloc, AssetDetailState>(
              builder: (context, state) {
                if (state.status == StatusAssetDetail.success) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'History',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      AppSpace.vertical(16),
                      Divider(color: AppColors.kBase),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.assetDetail?.length,
                        itemBuilder: (context, index) {
                          final movement = state.assetDetail?[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppSpace.vertical(18),
                              _descriptionItem(
                                'Type',
                                movement?.movementType ?? '',
                              ),
                              AppSpace.vertical(18),
                              _descriptionItem(
                                'From',
                                movement?.fromLocation ?? '',
                              ),
                              AppSpace.vertical(18),
                              _descriptionItem(
                                'To',
                                movement?.toLocation ?? '',
                              ),
                              AppSpace.vertical(18),
                              _descriptionItem(
                                'User',
                                movement?.movementBy ?? '',
                              ),
                              AppSpace.vertical(18),
                              _descriptionItem(
                                'Date',
                                DateFormat(
                                  'd - MMMM - y',
                                ).format(movement!.movementDate!),
                              ),
                              AppSpace.vertical(18),
                              _descriptionItem(
                                'Time',
                                DateFormat(
                                  'HH:mm',
                                ).format(movement.movementDate!),
                              ),
                              AppSpace.vertical(18),
                              _descriptionItem(
                                'References Number',
                                movement.referencesNumber ?? '',
                              ),
                              AppSpace.vertical(18),
                              _descriptionItem('Notes', movement.notes ?? ''),
                              AppSpace.vertical(24),
                              if (index != state.assetDetail!.length - 1)
                                Divider(color: AppColors.kBase),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
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
