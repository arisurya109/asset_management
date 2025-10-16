// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/features/asset_registration/domain/entities/asset_registration.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class DataSourceInventory extends DataTableSource {
  final List<AssetRegistration?> data;
  void Function(
    String assetId,
    String type,
    int quantity,
    String location,
    String box,
  )?
  onTap;

  DataSourceInventory(this.data, this.onTap);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length || data[index] == null) return null;
    final item = data[index]!;

    return DataRow2(
      onTap: () => onTap?.call(
        item.assetCode!,
        item.type ?? '',
        item.quantity!,
        item.locationDetail ?? '',
        item.location ?? '',
      ),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white70 : Colors.black12,
      ),
      cells: [
        DataCell(Center(child: Text('${index + 1}'))),
        DataCell(Center(child: Text(item.assetCode ?? ''))),
        DataCell(Center(child: Text(item.type ?? ''))),
        DataCell(Center(child: Text(item.model ?? ''))),
        DataCell(Center(child: Text('${item.quantity}'))),
        DataCell(Center(child: Text(item.locationDetail ?? ''))),
        DataCell(Center(child: Text(item.location ?? '-'))),
        DataCell(Center(child: Text(item.remarks ?? '-'))),
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
