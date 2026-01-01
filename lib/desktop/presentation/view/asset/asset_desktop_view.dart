import 'package:asset_management/core/core.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_excel_windows.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/asset_desktop/asset_desktop_bloc.dart';
import '../../bloc/authentication_desktop/authentication_desktop_bloc.dart';

class AssetDesktopView extends StatefulWidget {
  const AssetDesktopView({super.key});

  @override
  State<AssetDesktopView> createState() => _AssetDesktopViewState();
}

class _AssetDesktopViewState extends State<AssetDesktopView> {
  late ScrollController _horizontalScroll;

  @override
  void initState() {
    _horizontalScroll = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _horizontalScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasPermission =
        context.read<AuthenticationDesktopBloc>().state.user?.modules?.any((e) {
          return e.containsValue('assets_add');
        }) ??
        false;
    return Column(
      children: [
        AppHeaderDesktop(title: 'Asset', hasPermission: hasPermission),
        AppBodyDesktop(
          body: BlocBuilder<AssetDesktopBloc, AssetDesktopState>(
            builder: (context, state) {
              final datas =
                  state.assets?.asMap().entries.map((entry) {
                    int index = entry.key;
                    var e = entry.value;

                    return {
                      'id': e.id.toString(),
                      'no': (index + 1).toString(),
                      'asset_code': e.assetCode ?? '',
                      'serial_number': e.serialNumber ?? '',
                      'type': e.types ?? '',
                      'category': e.category ?? '',
                      'brand': e.brand ?? '',
                      'model': e.model ?? '',
                      'uom': e.uom == 1 ? 'UNIT' : 'PCS',
                      'quantity': e.quantity.toString(),
                      'location': e.location ?? '',
                      'location_detail': e.locationDetail ?? '',
                      'status': e.status ?? '',
                      'condition': e.conditions ?? '',
                      'color': e.color ?? '',
                      'purchase_order': e.purchaseOrder ?? '',
                      'remarks': e.remarks ?? '',
                    };
                  }).toList() ??
                  [];

              return AppNewTable(
                onAdd: () {},
                titleAdd: 'Add Asset',
                datas: datas,
                horizontalScrollController: _horizontalScroll,
                hintTextField: 'Search...',
                onTap: (data) => context.push('/asset/detail'),
                minWidth: 1300,
                onExport: () => _exportExcel(datas),
                columns: [
                  AppDataTableColumn(label: 'NO', key: 'no', width: 45),
                  AppDataTableColumn(
                    label: 'CODE',
                    key: 'asset_code',
                    width: 160,
                  ),
                  AppDataTableColumn(
                    label: 'SERIAL NUMBER',
                    key: 'serial_number',
                    width: 160,
                  ),
                  AppDataTableColumn(label: 'MODEL', key: 'model', width: 170),
                  AppDataTableColumn(
                    label: 'LOCATION',
                    key: 'location_detail',
                    width: 160,
                  ),
                  AppDataTableColumn(label: 'QTY', key: 'quantity', width: 60),
                  AppDataTableColumn(
                    label: 'STATUS',
                    key: 'status',
                    width: 120,
                    badgeConfig: {
                      'use': AppColors.kBlue,
                      'ready': AppColors.kGreen,
                      'repair': AppColors.kYellow,
                      'disposal': AppColors.kRed,
                    },
                  ),
                  AppDataTableColumn(
                    label: 'CONDITION',
                    key: 'condition',
                    width: 130,
                    badgeConfig: {
                      'new': AppColors.kGreen,
                      'good': AppColors.kBase,
                      'old': AppColors.kBlue,
                      'bad': AppColors.kRed,
                      'need to check': AppColors.kYellow,
                    },
                  ),
                  AppDataTableColumn(
                    label: 'PO NUMBER',
                    key: 'purchase_order',
                    width: 110,
                  ),
                  AppDataTableColumn(
                    label: 'REMARKS',
                    key: 'remarks',
                    isExpanded: true,
                  ),
                ],
                isLoading: state.status == StatusAssetDesktop.loading,
                onSearchSubmit: (query) => context.read<AssetDesktopBloc>().add(
                  OnFindAssetsByQuery(query),
                ),
                onClear: () =>
                    context.read<AssetDesktopBloc>().add(OnFindAllAssets()),
              );
            },
          ),
        ),
      ],
    );
  }

  _exportExcel(List<Map<String, String>> datas) {
    final dataForExport = datas.map((item) {
      final newItem = Map<String, String>.from(item);
      newItem.remove('id');
      return newItem;
    }).toList();

    final now = DateTime.now();
    final timestamp =
        "${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}";

    AppExcelWindows.exportAssetData(
      columnLabels: [
        'NO',
        'ASSET CODE',
        'SERIAL NUMBER',
        'TYPE',
        'CATEGORY',
        'BRAND',
        'MODEL',
        'UOM',
        'QUANTITY',
        'LOCATION',
        'LOCATION_DETAIL',
        'STATUS',
        'CONDITION',
        'COLOR',
        'PURCHASE ORDER',
        'REMARKS',
      ],
      tableData: dataForExport,
      fileName: 'asset_$timestamp',
    );
  }
}
