// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:asset_management/desktop/presentation/components/app_button_header_table.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_search_desktop.dart';

import '../../../core/core.dart';

class AppDataTableColumn {
  final String label;
  final String key;
  final double? width;
  final bool isExpanded; // Tambahkan ini
  final Map<String, Color>? badgeConfig;

  AppDataTableColumn({
    required this.label,
    required this.key,
    this.width,
    this.badgeConfig,
    this.isExpanded = false,
  });
}

// ignore: must_be_immutable
class AppNewTable extends StatefulWidget {
  final List<AppDataTableColumn> columns;
  final List<Map<String, String>> datas;
  final double? minWidth;
  final Function(String query) onSearchSubmit;
  final Function() onClear;
  final String? hintTextField;
  final Future Function()? onExport;
  final Function()? onAdd;
  final String? titleAdd;
  final void Function(Map<String, String> data)? onTap;
  final ScrollController? horizontalScrollController;
  int? rowsPerPage;
  List<int>? availableRowsPerPage;
  final Function(int index)? onPageChanged;
  final int totalData;
  final Function(int? rowsPerPage)? onRowsPerPageChanged;

  AppNewTable({
    super.key,
    required this.columns,
    required this.datas,
    this.minWidth = 1000,
    required this.onSearchSubmit,
    required this.onClear,
    this.hintTextField,
    this.onExport,
    this.onAdd,
    this.titleAdd,
    this.onTap,
    this.horizontalScrollController,
    this.rowsPerPage = 10,
    this.availableRowsPerPage = const [10, 20, 50, 100],
    this.onPageChanged,
    required this.totalData,
    this.onRowsPerPageChanged,
  });

  @override
  State<AppNewTable> createState() => _AppNewTableState();
}

class _AppNewTableState extends State<AppNewTable> {
  late TextEditingController _searchC;
  late PaginatorController _paginatorController;
  bool _isSearchActive = false;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  void _sort<T>(
    Comparable<T> Function(Map<String, String> d) getField,
    int columnIndex,
    bool ascending,
  ) {
    widget.datas.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      if (widget.columns[columnIndex].key == 'no') {
        final int aNum = int.tryParse(aValue.toString()) ?? 0;
        final int bNum = int.tryParse(bValue.toString()) ?? 0;
        return ascending ? aNum.compareTo(bNum) : bNum.compareTo(aNum);
      }

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  void initState() {
    _searchC = TextEditingController();
    _paginatorController = PaginatorController();
    super.initState();
  }

  @override
  void dispose() {
    _searchC.dispose();
    _paginatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_headerTable(), AppSpace.vertical(16), _bodyTable()],
    );
  }

  Widget _bodyTable() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          border: Border.all(color: const Color(0xFFE2E8F0)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: AsyncPaginatedDataTable2(
          wrapInCard: false,
          onPageChanged: widget.onPageChanged != null
              ? (value) => widget.onPageChanged!(value)
              : null,
          minWidth: widget.minWidth,
          controller: _paginatorController,
          empty: Center(child: Text('Not Found')),
          border: TableBorder(
            horizontalInside: BorderSide(color: const Color(0xFFE2E8F0)),
          ),
          availableRowsPerPage: widget.availableRowsPerPage!,
          onRowsPerPageChanged: (value) {
            if (value != null) {
              widget.rowsPerPage = value;

              _paginatorController.goToFirstPage();

              if (widget.onRowsPerPageChanged != null) {
                widget.onRowsPerPageChanged!(value);
              } else if (widget.onPageChanged != null) {
                widget.onPageChanged!(0);
              }
            }
          },
          isHorizontalScrollBarVisible:
              widget.horizontalScrollController != null ? true : false,
          horizontalScrollController: widget.horizontalScrollController,
          rowsPerPage: widget.rowsPerPage!,
          dividerThickness: 0,
          sortArrowAlwaysVisible: true,
          headingRowHeight: 40,
          dataRowHeight: 50,
          columnSpacing: 20,
          horizontalMargin: 24,
          isVerticalScrollBarVisible: true,
          headingTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: Color(0xFF64748B),
          ),
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          sortArrowIcon: Icons.keyboard_arrow_up,
          headingRowDecoration: BoxDecoration(
            color: Color(0xFFF8FAFC),
            border: Border(bottom: BorderSide(color: const Color(0xFFE2E8F0))),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          columns: widget.columns.asMap().entries.map((entry) {
            var e = entry.value;
            return DataColumn2(
              label: Text(e.label),
              fixedWidth: e.width,
              size: e.isExpanded
                  ? ColumnSize.L
                  : (e.width == null ? ColumnSize.S : ColumnSize.M),
              onSort: (columnIndex, ascending) {
                _sort((d) => d[e.key] ?? '', columnIndex, ascending);
              },
            );
          }).toList(),
          source: AppAsyncDataSource(
            datas: widget.datas,
            columns: widget.columns,
            onTap: widget.onTap,
            totalData: widget.totalData,
          ),
        ),
      ),
    );
  }

  Widget _headerTable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (widget.onAdd != null)
          AppButtonHeaderTable(
            title: widget.titleAdd,
            icons: Icons.add,
            onPressed: widget.onAdd,
            borderColor: AppColors.kBase,
            iconColors: AppColors.kBase,
            titleColor: AppColors.kBase,
          ),
        Expanded(child: SizedBox()),
        if (widget.onExport != null)
          AppButtonHeaderTable(
            title: 'Export',
            icons: Icons.download_rounded,
            onPressed: widget.onExport,
            borderColor: AppColors.kBase,
            iconColors: AppColors.kBase,
            titleColor: AppColors.kBase,
          ),
        if (widget.onExport != null) AppSpace.horizontal(16),
        AppTextFieldSearchDesktop(
          controller: _searchC,
          withSearchIcon: true,
          hintText: widget.hintTextField,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              setState(() => _isSearchActive = true);

              _paginatorController.goToFirstPage();

              widget.onSearchSubmit(value);
            }
          },
          suffixIcon: _isSearchActive
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 16),
                  onPressed: () {
                    setState(() {
                      _searchC.clear();
                      _isSearchActive = false;
                    });

                    _paginatorController.goToFirstPage();

                    widget.onClear();
                  },
                )
              : null,
          onChanged: (value) {
            if (value.isEmpty && _isSearchActive) {
              setState(() => _isSearchActive = false);
              widget.onClear();
            }
          },
        ),
      ],
    );
  }
}

class AppAsyncDataSource extends AsyncDataTableSource {
  final List<Map<String, String>> datas;
  final int totalData;
  final List<AppDataTableColumn> columns;
  final void Function(Map<String, String> data)? onTap;

  AppAsyncDataSource({
    required this.datas,
    required this.columns,
    this.onTap,
    required this.totalData,
  });

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    final List<DataRow> rows = datas.map((data) {
      return DataRow2(
        onTap: onTap != null ? () => onTap!(data) : null,
        cells: columns.map((col) {
          final String value = data[col.key] ?? "";

          if (col.badgeConfig != null) {
            final color =
                col.badgeConfig![value.toLowerCase()] ?? AppColors.kBase;
            return DataCell(_buildBadge(value, color));
          }

          return DataCell(
            Text(
              value,
              style: const TextStyle(color: Color(0xFF334155), fontSize: 12),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      );
    }).toList();

    return AsyncRowsResponse(totalData, rows);
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalData;

  @override
  int get selectedRowCount => 0;
}

class AppNewDataTable extends DataTableSource {
  final List<Map<String, String>> datas;
  final int totalData;
  final List<AppDataTableColumn> columns;
  final void Function(Map<String, String> data)? onTap;
  AppNewDataTable({
    required this.datas,
    required this.columns,
    this.onTap,
    required this.totalData,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= datas.length) return null;
    final data = datas[index];

    return DataRow2(
      onTap: onTap != null ? () => onTap!(data) : null,
      cells: columns.map((col) {
        final String value = data[col.key] ?? "-";

        if (col.badgeConfig != null) {
          final color =
              col.badgeConfig![value.toLowerCase()] ?? AppColors.kBase;
          return DataCell(_buildBadge(value, color));
        }

        return DataCell(
          Text(
            value,
            style: const TextStyle(color: Color(0xFF334155), fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => totalData;
  @override
  int get selectedRowCount => 0;
}
