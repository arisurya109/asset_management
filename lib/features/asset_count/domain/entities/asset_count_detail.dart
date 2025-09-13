// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetCountDetail extends Equatable {
  int? countId;
  String? assetId;
  String? serialNumber;
  String? assetName;
  String? brandName;
  String? location;
  String? box;
  String? status;
  String? condition;

  AssetCountDetail({
    this.countId,
    this.assetId,
    this.serialNumber,
    this.assetName,
    this.brandName,
    this.location,
    this.box,
    this.status,
    this.condition,
  });

  @override
  List<Object?> get props => [
    assetId,
    serialNumber,
    assetName,
    brandName,
    location,
    box,
    status,
    condition,
  ];
}
