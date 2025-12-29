// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/domain/entities/master/preparation_template_item.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DataSource extends DataTableSource {
  final List<PreparationTemplateItem?> data;
  void Function(String asset, int modelId, int quantity)? onTap;

  DataSource(this.data, this.onTap);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length || data[index] == null) return null;
    final item = data[index]!;

    return DataRow2(
      onTap: () =>
          onTap?.call(item.assetModel ?? '', item.modelId!, item.quantity!),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white70 : Colors.black12,
      ),
      cells: [
        DataCell(Center(child: Text('${index + 1}'))),
        DataCell(Center(child: Text(item.assetType ?? ''))),
        DataCell(Center(child: Text(item.assetBrand ?? ''))),
        DataCell(Center(child: Text(item.assetCategory ?? ''))),
        DataCell(Center(child: Text(item.assetModel ?? ''))),
        DataCell(Center(child: Text(item.quantity.toString()))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
