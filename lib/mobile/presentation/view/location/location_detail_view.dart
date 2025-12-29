import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/mobile/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';

class LocationDetailView extends StatelessWidget {
  final Location params;

  const LocationDetailView({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileLocationDetail(context),
      mobileMScaffold: _mobileLocationDetail(context, isLarge: false),
    );
  }

  Widget _mobileLocationDetail(BuildContext context, {bool isLarge = true}) {
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
                      context.showSnackbar(
                        'Success reprint location',
                        fontSize: isLarge ? 14 : 12,
                      );
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpace.vertical(12),
              _descriptionItem(
                'Name',
                params.name ?? '',
                fontSize: isLarge ? 14 : 12,
              ),
              AppSpace.vertical(18),
              _descriptionItem(
                'Type',
                params.locationType ?? '',
                fontSize: isLarge ? 14 : 12,
              ),
              AppSpace.vertical(18),
              _descriptionItem(
                'Init',
                params.init ?? '',
                fontSize: isLarge ? 14 : 12,
              ),
              AppSpace.vertical(18),
              _descriptionItem(
                'Code',
                params.code ?? '',
                fontSize: isLarge ? 14 : 12,
              ),
              AppSpace.vertical(18),
              _descriptionItem(
                'Box Type',
                params.boxType ?? '',
                fontSize: isLarge ? 14 : 12,
              ),
              AppSpace.vertical(18),
              _descriptionItem(
                'Parent',
                params.parentName ?? '',
                fontSize: isLarge ? 14 : 12,
              ),
              AppSpace.vertical(18),
            ],
          ),
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
