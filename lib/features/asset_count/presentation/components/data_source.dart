// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/features/asset_count/domain/entities/asset_count_detail.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DataSource extends DataTableSource {
  final List<AssetCountDetail?> data;
  void Function(
    String assetId,
    String assetName,
    String location,
    String box,
    String condition,
    int quantity,
  )?
  onTap;

  DataSource(this.data, this.onTap);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length || data[index] == null) return null;
    final item = data[index]!;

    return DataRow2(
      onTap: () => onTap?.call(
        item.assetId!,
        item.assetName ?? '',
        item.location!,
        item.box ?? '',
        item.condition ?? '',
        (item.quantity) as int,
      ),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white70 : Colors.black12,
      ),
      cells: [
        DataCell(Center(child: Text('${index + 1}'))),
        DataCell(Center(child: Text(item.assetId ?? ''))),
        DataCell(Center(child: Text(item.assetName ?? ''))),
        DataCell(Center(child: Text(item.location ?? ''))),
        DataCell(Center(child: Text(item.box ?? ''))),
        DataCell(Center(child: Text(item.condition ?? ''))),
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
