// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:equatable/equatable.dart';

class InventoryBox extends Equatable {
  int? id;
  String? name;
  int? quantityAsset;
  String? boxType;

  InventoryBox({this.id, this.name, this.quantityAsset, this.boxType});

  @override
  List<Object?> get props => [id, name, quantityAsset, boxType];
}
