// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages, must_be_immutable
import 'package:equatable/equatable.dart';

class AssetPreparationDetail extends Equatable {
  int? preparationId;
  String? asset;
  int? quantity;
  String? type;
  String? location;
  String? box;

  AssetPreparationDetail({
    this.preparationId,
    this.asset,
    this.quantity,
    this.type,
    this.location,
    this.box,
  });

  @override
  List<Object?> get props {
    return [preparationId, asset, quantity, type, location, box];
  }
}
