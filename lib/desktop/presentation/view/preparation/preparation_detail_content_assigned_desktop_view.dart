import 'package:asset_management/desktop/presentation/components/app_new_table.dart';
import 'package:asset_management/desktop/presentation/components/app_table_fixed.dart';
import 'package:flutter/material.dart';

class PreparationDetailContentAssignedDesktopView extends StatelessWidget {
  const PreparationDetailContentAssignedDesktopView({
    super.key,
    required this.datasTable,
  });

  final List<Map<String, String>> datasTable;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppTableFixed(
        datas: datasTable,
        columns: [
          AppDataTableColumn(label: 'NO', key: 'no', width: 50),
          AppDataTableColumn(label: 'TYPE', key: 'type'),
          AppDataTableColumn(
            label: 'CATEGORY',
            key: 'category',
            isExpanded: true,
          ),
          AppDataTableColumn(label: 'MODEL', key: 'model', isExpanded: true),
          AppDataTableColumn(label: 'PO NUMBER', key: 'purchase_order'),
          AppDataTableColumn(label: 'STATUS', key: 'status'),
          AppDataTableColumn(label: 'QUANTITY', key: 'quantity'),
        ],
      ),
    );
  }
}
