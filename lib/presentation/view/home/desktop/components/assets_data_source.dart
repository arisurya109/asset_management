// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class AssetsDataSource extends DataTableSource {
  final List<AssetEntity?> data;
  void Function(String asset, int id, int quantity)? onTap;

  AssetsDataSource(this.data, this.onTap);

  @override
  DataRow? getRow(int index) {
    if (index >= data.length || data[index] == null) return null;
    final item = data[index]!;

    return DataRow2(
      onTap: () => onTap?.call(item.assetCode ?? '', item.id!, item.quantity!),
      decoration: BoxDecoration(
        color: index.isEven ? Colors.white70 : Colors.black12,
      ),
      cells: [
        DataCell(Center(child: Text('${index + 1}'))),
        DataCell(Center(child: Text(item.assetCode ?? ''))),
        DataCell(Center(child: Text(item.serialNumber ?? ''))),
        DataCell(Center(child: Text(item.types ?? ''))),
        DataCell(Center(child: Text(item.category ?? ''))),
        DataCell(Center(child: Text(item.brand ?? ''))),
        DataCell(Center(child: Text(item.location ?? ''))),
        DataCell(Center(child: Text(item.conditions ?? ''))),
        DataCell(Center(child: Text(item.status ?? ''))),
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
