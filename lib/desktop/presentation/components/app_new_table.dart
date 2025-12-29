import 'package:asset_management/desktop/presentation/components/app_button_header_table.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_search_desktop.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

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

class AppNewTable extends StatefulWidget {
  final List<AppDataTableColumn> columns;
  final List<Map<String, String>> datas;
  final double? minWidth;
  final bool isLoading;
  final Function(String query) onSearchSubmit;
  final Function() onClear;
  final String? hintTextField;
  final Function()? onExport;
  final Function()? onAdd;
  final String? titleAdd;
  final void Function(Map<String, String> data)? onTap;
  final ScrollController? horizontalScrollController;

  const AppNewTable({
    super.key,
    required this.datas,
    required this.columns,
    required this.isLoading,
    required this.onSearchSubmit,
    required this.onClear,
    this.hintTextField,
    this.onExport,
    this.onAdd,
    this.titleAdd,
    this.onTap,
    this.horizontalScrollController,
    this.minWidth = 1000,
  });

  @override
  State<AppNewTable> createState() => _AppNewTableState();
}

class _AppNewTableState extends State<AppNewTable> {
  late TextEditingController _searchC;
  late PaginatorController _paginatorController;
  int rowPerPage = 10;
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
        child: PaginatedDataTable2(
          wrapInCard: false,
          minWidth: widget.minWidth,
          controller: _paginatorController,
          empty: widget.isLoading
              ? Center(child: CircularProgressIndicator(color: AppColors.kBase))
              : Center(child: Text('Not Found')),
          border: TableBorder(
            horizontalInside: BorderSide(color: const Color(0xFFE2E8F0)),
          ),
          availableRowsPerPage: [10, 20, 50, 100],
          onRowsPerPageChanged: (value) => setState(() {
            if (value != null) {
              setState(() => rowPerPage = value);
            }
          }),
          isHorizontalScrollBarVisible:
              widget.horizontalScrollController != null ? true : false,
          horizontalScrollController: widget.horizontalScrollController,
          rowsPerPage: rowPerPage,
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
          source: AppNewDataTable(
            datas: widget.datas,
            columns: widget.columns,
            onTap: widget.onTap,
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

class AppNewDataTable extends DataTableSource {
  final List<Map<String, String>> datas;
  final List<AppDataTableColumn> columns;
  final void Function(Map<String, String> data)? onTap;
  AppNewDataTable({required this.datas, required this.columns, this.onTap});

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
  int get rowCount => datas.length;
  @override
  int get selectedRowCount => 0;
}
