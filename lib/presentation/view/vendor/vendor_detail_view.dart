import 'package:asset_management/domain/entities/master/vendor.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class VendorDetailView extends StatelessWidget {
  final Vendor params;

  const VendorDetailView({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Detail'),

        // actions:
        //     params.locationType == 'BOX' ||
        //         params.locationType == 'RACK' ||
        //         params.locationType == 'TABLE'
        //     ? [
        //         BlocListener<PrinterBloc, PrinterState>(
        //           listener: (context, state) {
        //             if (state.status == PrinterStatus.success) {
        //               context.showSnackbar('Success reprint asset code');
        //             }
        //           },
        //           child: Padding(
        //             padding: const EdgeInsets.only(right: 16),
        //             child: InkWell(
        //               onTap: () => context.read<PrinterBloc>().add(
        //                 OnPrintLocation(params.name!),
        //               ),
        //               borderRadius: BorderRadius.circular(32),
        //               child: CircleAvatar(
        //                 backgroundColor: Colors.transparent,
        //                 child: AppAssetImg(
        //                   Assets.iReprint,
        //                   color: AppColors.kBase,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ]
        //     : [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpace.vertical(12),
              _descriptionItem('Name', params.name ?? ''),
              AppSpace.vertical(18),
              _descriptionItem('Init', params.init ?? ''),
              AppSpace.vertical(18),
              _descriptionItem('Phone', params.phone ?? ''),
              AppSpace.vertical(18),
              _descriptionItem('Description', params.description ?? ''),
            ],
          ),
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
