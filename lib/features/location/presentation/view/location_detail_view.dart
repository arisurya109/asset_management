import 'package:asset_management/features/location/location_export.dart';
import 'package:asset_management/features/printer/presentation/bloc/printer/printer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

class LocationDetailView extends StatelessWidget {
  final Location params;

  const LocationDetailView({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Detail'),
        actions:
            params.locationType == 'BOX' ||
                params.locationType == 'RACK' ||
                params.locationType == 'TABLE'
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
                        OnPrintLocation(params.name!),
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
            _descriptionItem('Name', params.name ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Type', params.locationType ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Init', params.init ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Code', params.code ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Box Type', params.boxType ?? ''),
            AppSpace.vertical(18),
            _descriptionItem('Parent', params.parentName ?? ''),
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
