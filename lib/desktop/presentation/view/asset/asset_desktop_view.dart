import 'dart:io';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_excel_windows.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import 'package:asset_management/desktop/presentation/cubit/datas/datas_desktop_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../bloc/asset_desktop/asset_desktop_bloc.dart';
import '../../bloc/authentication_desktop/authentication_desktop_bloc.dart';

class AssetDesktopView extends StatefulWidget {
  const AssetDesktopView({super.key});

  @override
  State<AssetDesktopView> createState() => _AssetDesktopViewState();
}

class _AssetDesktopViewState extends State<AssetDesktopView> {
  late ScrollController _horizontalScroll;
  final List<int> _availableRowsPerPage = [10, 20, 50, 100];
  int _rowsPerPage = 10;
  int _currentPage = 1;
  String? _searchQuery;

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
                  state.response?.assets?.asMap().entries.map((entry) {
                    int index = entry.key;
                    var e = entry.value;

                    int noUrut =
                        ((_currentPage - 1) * _rowsPerPage) + index + 1;

                    return {
                      'id': e.id.toString(),
                      'no': noUrut.toString(),
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
                totalData: state.response?.totalData ?? 0,
                titleAdd: 'Add Asset',
                datas: datas,
                availableRowsPerPage: _availableRowsPerPage,
                rowsPerPage: _rowsPerPage,
                horizontalScrollController: _horizontalScroll,
                hintTextField: 'Search...',
                minWidth: 1300,
                onExport: () async => await _exportExcel(_searchQuery),
                onTap: (data) => context.push('/asset/detail/${data['id']}'),
                onRowsPerPageChanged: (rowsPerPage) {
                  if (rowsPerPage != null) {
                    _rowsPerPage = rowsPerPage;
                    _currentPage = 1;
                    context.read<AssetDesktopBloc>().add(
                      OnFindAssetPagination(
                        limit: _rowsPerPage,
                        page: _currentPage,
                        query: _searchQuery,
                      ),
                    );
                  }
                },
                onPageChanged: (index) {
                  _currentPage = (index / _rowsPerPage).toInt() + 1;
                  context.read<AssetDesktopBloc>().add(
                    OnFindAssetPagination(
                      limit: _rowsPerPage,
                      page: _currentPage,
                      query: _searchQuery,
                    ),
                  );
                },
                onSearchSubmit: (query) {
                  _currentPage = 1;
                  setState(() {
                    _searchQuery = query;
                  });
                  context.read<AssetDesktopBloc>().add(
                    OnFindAssetPagination(
                      limit: _rowsPerPage,
                      page: 1,
                      query: _searchQuery,
                    ),
                  );
                },
                onClear: () {
                  setState(() {
                    _searchQuery = null;
                  });
                  context.read<AssetDesktopBloc>().add(
                    OnFindAssetPagination(
                      limit: _rowsPerPage,
                      page: _currentPage,
                    ),
                  );
                },

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
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _exportExcel(String? query) async {
    try {
      final assets = await context.read<DatasDesktopCubit>().getAssetsExported(
        query,
      );

      if (assets == null || assets.isEmpty) {
        AppToast.show(
          context: context,
          type: ToastType.warning,
          message: "Tidak ada data untuk diekspor",
        );
        return;
      }

      final datas = assets.asMap().entries.map((entry) {
        int index = entry.key;
        var e = entry.value;

        return {
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
      }).toList();

      final now = DateTime.now();
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(now);

      final File exportedFile = await AppExcelWindows.exportAssetData(
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
        tableData: datas,
        fileName: 'asset_$timestamp',
      );

      AppToast.show(
        context: context,
        type: ToastType.success,
        message:
            "Asset successfully exported: ${exportedFile.path.split('\\').last}",
      );
    } catch (e) {
      if (e.toString() != 'An error occurred, please try again') {
        AppToast.show(
          context: context,
          type: ToastType.error,
          message: e.toString(),
        );
      }
    }
  }
}
