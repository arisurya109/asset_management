import 'package:asset_management/core/core.dart';
import 'package:asset_management/desktop/presentation/bloc/asset_detail_desktop/asset_detail_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import 'package:asset_management/desktop/presentation/components/app_table_fixed.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../components/app_header_desktop.dart';

class AssetDetailDesktopView extends StatelessWidget {
  const AssetDetailDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeaderDesktop(title: 'Asset Detail', withBackButton: true),
        AppBodyDesktop(
          body: BlocBuilder<AssetDetailDesktopBloc, AssetDetailDesktopState>(
            builder: (context, state) {
              final asset = state.response?.asset;
              final histories = state.response?.history;

              final datas =
                  histories?.asMap().entries.map((entry) {
                    int index = entry.key;
                    var e = entry.value;

                    return {
                      'id': e.id.toString(),
                      'no': (index + 1).toString(),
                      'date': DateFormat('y-MM-dd').format(e.movementDate!),
                      'time': DateFormat(
                        'HH:mm',
                        'id_ID',
                      ).format(e.movementDate!),
                      'type': e.movementType ?? '',
                      'from': e.fromLocation ?? '',
                      'to': e.toLocation ?? '',
                    };
                  }).toList() ??
                  [];
              return Column(
                children: [
                  _assetInformation(context, asset),
                  AppSpace.vertical(12),
                  Expanded(
                    child: AppTableFixed(
                      datas: datas,
                      emptyMessage: 'No asset transaction records',
                      columns: [
                        AppDataTableColumn(label: 'NO', key: 'no', width: 50),
                        AppDataTableColumn(
                          label: 'DATE',
                          key: 'date',
                          width: 150,
                        ),
                        AppDataTableColumn(
                          label: 'TIME',
                          key: 'time',
                          width: 100,
                        ),
                        AppDataTableColumn(label: 'TYPE', key: 'type'),
                        AppDataTableColumn(label: 'FROM LOCATION', key: 'from'),
                        AppDataTableColumn(label: 'TO LOCATION', key: 'to'),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _assetInformation(BuildContext context, AssetEntity? asset) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: AppColors.kWhite,
        border: Border.all(color: AppColors.kGrey, width: 0.25),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: [
                  Icon(Icons.info, size: 20, color: AppColors.kBase),
                  AppSpace.horizontal(8),
                  Text(
                    'Asset Information',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: AppColors.kBase.withOpacity(0.2),
                ),
                child: Text(
                  asset?.status ?? '-',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: AppColors.kBase,
                  ),
                ),
              ),
            ],
          ),
          AppSpace.vertical(16),
          Row(
            children: [
              _wrappingTwoContent(
                context,
                topTitle: 'ASSET CODE',
                topValue: asset?.assetCode,
                bottomTitle: 'MODEL',
                bottomValue: asset?.model,
              ),
              _wrappingTwoContent(
                context,
                topTitle: 'SERIAL NUMBER',
                topValue: asset?.serialNumber,
                bottomTitle: 'CATEGORY',
                bottomValue: asset?.category,
              ),
              _wrappingTwoContent(
                context,
                topTitle: 'CONDITION',
                topValue: asset?.conditions,
                bottomTitle: 'BRAND',
                bottomValue: asset?.brand,
              ),
              _wrappingTwoContent(
                context,
                topTitle: 'LOCATION',
                topValue: asset?.locationDetail,
                bottomTitle: 'TYPE',
                bottomValue: asset?.types,
              ),
              _wrappingTwoContent(
                context,
                topTitle: 'PURCHASE ORDER',
                topValue:
                    (asset?.purchaseOrder != null || asset?.purchaseOrder != '')
                    ? asset?.purchaseOrder
                    : '-',
                bottomTitle: 'NOTES',
                bottomValue: (asset?.remarks != null || asset?.remarks != '')
                    ? asset?.remarks
                    : '-',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _wrappingTwoContent(
    BuildContext context, {
    required String topTitle,
    String? topValue,
    required String bottomTitle,
    String? bottomValue,
  }) {
    return Container(
      height: 90,
      width: (context.deviceWidth - 321) / 5,
      margin: EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _content(title: topTitle, value: topValue),
          _content(title: bottomTitle, value: bottomValue),
        ],
      ),
    );
  }

  Widget _content({required String title, String? value}) {
    return Wrap(
      direction: Axis.vertical,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 3,
      children: [
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.kGrey,
          ),
        ),
        Text(
          value ?? '-',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
