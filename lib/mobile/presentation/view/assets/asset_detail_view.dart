import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/mobile/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';

class AssetDetailView extends StatelessWidget {
  final AssetEntity params;

  const AssetDetailView({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileAssetDetails(context),
      mobileMScaffold: _mobileAssetDetails(context, isLarge: false),
    );
  }

  Widget _mobileAssetDetails(BuildContext context, {bool isLarge = true}) {
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
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Serial Number',
              params.serialNumber ?? '',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Type',
              params.types ?? '',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Category',
              params.category ?? '',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Brand',
              params.brand ?? '',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Model',
              params.model ?? '',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Color',
              params.color ?? '',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Quantity',
              params.uom == 1
                  ? '${params.quantity} Unit'
                  : '${params.quantity} Pcs',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Condition',
              params.conditions ?? '',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Status',
              params.status ?? '',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Location',
              params.locationDetail ?? '',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Purchase Order',
              params.purchaseOrder ?? '-',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            _descriptionItem(
              'Notes',
              params.remarks ?? '-',
              fontSize: isLarge ? 14 : 12,
            ),
            AppSpace.vertical(18),
            // BlocBuilder<AssetBloc, AssetState>(
            //   builder: (context, state) {
            //     if (state.status == StatusAsset.success) {
            //       return Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Center(
            //             child: Text(
            //               'History',
            //               style: TextStyle(
            //                 fontSize: isLarge ? 14 : 12,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ),
            //           AppSpace.vertical(16),
            //           Divider(color: AppColors.kBase),
            //           ListView.builder(
            //             shrinkWrap: true,
            //             physics: NeverScrollableScrollPhysics(),
            //             itemCount: state.assetDetails?.length,
            //             itemBuilder: (context, index) {
            //               final movement = state.assetDetails?[index];
            //               return Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   AppSpace.vertical(18),
            //                   _descriptionItem(
            //                     'Type',
            //                     movement?.movementType ?? '',
            //                     fontSize: isLarge ? 14 : 12,
            //                   ),
            //                   AppSpace.vertical(18),
            //                   _descriptionItem(
            //                     'From',
            //                     movement?.fromLocation ?? '',
            //                     fontSize: isLarge ? 14 : 12,
            //                   ),
            //                   AppSpace.vertical(18),
            //                   _descriptionItem(
            //                     'To',
            //                     movement?.toLocation ?? '',
            //                     fontSize: isLarge ? 14 : 12,
            //                   ),
            //                   AppSpace.vertical(18),
            //                   _descriptionItem(
            //                     'User',
            //                     movement?.movementBy ?? '',
            //                     fontSize: isLarge ? 14 : 12,
            //                   ),
            //                   AppSpace.vertical(18),
            //                   _descriptionItem(
            //                     'Date',
            //                     DateFormat(
            //                       'd - MMMM - y',
            //                     ).format(movement!.movementDate!),
            //                     fontSize: isLarge ? 14 : 12,
            //                   ),
            //                   AppSpace.vertical(18),
            //                   _descriptionItem(
            //                     'Time',
            //                     DateFormat(
            //                       'HH:mm',
            //                     ).format(movement.movementDate!),
            //                     fontSize: isLarge ? 14 : 12,
            //                   ),
            //                   AppSpace.vertical(18),
            //                   _descriptionItem(
            //                     'References Number',
            //                     movement.referencesNumber ?? '',
            //                     fontSize: isLarge ? 14 : 12,
            //                   ),
            //                   AppSpace.vertical(18),
            //                   _descriptionItem(
            //                     'Notes',
            //                     movement.notes ?? '',
            //                     fontSize: isLarge ? 14 : 12,
            //                   ),
            //                   AppSpace.vertical(24),
            //                   if (index != state.assetDetails!.length - 1)
            //                     Divider(color: AppColors.kBase),
            //                 ],
            //               );
            //             },
            //           ),
            //         ],
            //       );
            //     }
            //     return SizedBox();
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Widget _descriptionItem(String title, String value, {double fontSize = 12}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
        ),
        AppSpace.vertical(3),
        Text(
          value,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
