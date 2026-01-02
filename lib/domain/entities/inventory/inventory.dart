// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:equatable/equatable.dart';

import 'package:asset_management/domain/entities/inventory/inventory_box.dart';

class Inventory extends Equatable {
  int? totalBox;
  List<InventoryBox>? boxs;

  Inventory({this.totalBox, this.boxs});

  @override
  List<Object?> get props => [totalBox, boxs];
}
