// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:asset_management/desktop/presentation/components/app_button_header_table.dart';
import 'package:asset_management/desktop/presentation/components/app_text_field_search_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import '../../../core/core.dart';

class AppTableFixed extends StatefulWidget {
  final List<AppDataTableColumn> columns;
  final List<Map<String, String>> datas;
  final double? minWidth;
  final Function(String query)? onSearchSubmit;
  final Function()? onClear;
  final String? hintTextField;
  final Function()? onExport;
  final Function()? onAdd;
  final String? titleAdd;
  final void Function(Map<String, String> data)? onTap;
  final ScrollController? horizontalScrollController;
  final int rowsPerPage;
  final String? emptyMessage;

  const AppTableFixed({
    super.key,
    required this.columns,
    required this.datas,
    this.minWidth = 1000,
    this.onSearchSubmit,
    this.onClear,
    this.hintTextField,
    this.onExport,
    this.onAdd,
    this.titleAdd,
    this.onTap,
    this.horizontalScrollController,
    this.rowsPerPage = 10,
    this.emptyMessage,
  });

  @override
  State<AppTableFixed> createState() => _AppTableFixedState();
}

class _AppTableFixedState extends State<AppTableFixed> {
  late TextEditingController _searchC;
  late PaginatorController _paginatorController;
  bool _isSearchActive = false;
  late int _rowsPerPage;

  @override
  void initState() {
    _searchC = TextEditingController();
    _paginatorController = PaginatorController();
    _rowsPerPage = widget.rowsPerPage;
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
          minWidth: widget.minWidth,
          wrapInCard: false,
          controller: _paginatorController,
          hidePaginator: false,
          rowsPerPage: _rowsPerPage,
          onRowsPerPageChanged: (value) {
            if (value != null) setState(() => _rowsPerPage = value);
          },
          border: const TableBorder(
            horizontalInside: BorderSide(color: Color(0xFFE2E8F0)),
          ),
          isHorizontalScrollBarVisible:
              widget.horizontalScrollController != null,
          horizontalScrollController: widget.horizontalScrollController,
          dividerThickness: 0,
          headingRowHeight: 40,
          empty: Center(
            child: Text(
              widget.emptyMessage ?? 'Not found records',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.kGrey,
              ),
            ),
          ),
          dataRowHeight: 50,
          columnSpacing: 20,
          horizontalMargin: 24,
          headingTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: Color(0xFF64748B),
          ),
          headingRowDecoration: const BoxDecoration(
            color: Color(0xFFF8FAFC),
            border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
          columns: widget.columns.map((e) {
            return DataColumn2(
              label: Text(e.label),
              fixedWidth: e.width,
              size: e.isExpanded
                  ? ColumnSize.L
                  : (e.width == null ? ColumnSize.S : ColumnSize.M),
            );
          }).toList(),
          source: LocalDataTableSource(
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
        const Expanded(child: SizedBox()),
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
        if (widget.onSearchSubmit != null && widget.onClear != null)
          AppTextFieldSearchDesktop(
            controller: _searchC,
            withSearchIcon: true,
            hintText: widget.hintTextField,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                setState(() => _isSearchActive = true);
                widget.onSearchSubmit!(value);
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
                      widget.onClear!();
                    },
                  )
                : null,
            onChanged: (value) {
              if (value.isEmpty && _isSearchActive) {
                setState(() => _isSearchActive = false);
                widget.onClear!();
              }
            },
          ),
      ],
    );
  }
}

class LocalDataTableSource extends DataTableSource {
  final List<Map<String, String>> datas;
  final List<AppDataTableColumn> columns;
  final void Function(Map<String, String> data)? onTap;

  LocalDataTableSource({
    required this.datas,
    required this.columns,
    this.onTap,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= datas.length) return null;
    final data = datas[index];

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
