// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingModel extends Equatable {
  int? id;
  String? code;
  String? type;
  String? status;
  int? destinationId;
  String? destination;
  int? temporaryLocationId;
  String? temporaryLocation;
  int? totalBox;
  String? notes;
  int? totalItems;
  int? totalQuantiy;

  PickingModel({
    this.id,
    this.code,
    this.type,
    this.status,
    this.destinationId,
    this.destination,
    this.temporaryLocationId,
    this.temporaryLocation,
    this.totalBox,
    this.notes,
    this.totalItems,
    this.totalQuantiy,
  });

  factory PickingModel.fromJson(Map<String, dynamic> map) {
    return PickingModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      destinationId: map['destination']['id'] != null
          ? map['destination']['id'] as int
          : null,
      destination: map['destination']['name'] != null
          ? map['destination']['name'] as String
          : null,
      temporaryLocationId: map['temporary_location']['id'] != null
          ? map['temporary_location']['id'] as int
          : null,
      temporaryLocation: map['temporary_location']['name'] != null
          ? map['temporary_location']['name'] as String
          : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      totalItems: map['total_items'] != null ? map['total_items'] as int : null,
      totalQuantiy: map['total_quantity'] != null
          ? map['total_quantity'] as int
          : null,
    );
  }

  Picking toEntity() {
    return Picking(
      id: id,
      code: code,
      destination: destination,
      destinationId: destinationId,
      notes: notes,
      status: status,
      temporaryLocation: temporaryLocation,
      temporaryLocationId: temporaryLocationId,
      totalBox: totalBox,
      totalItems: totalItems,
      totalQuantiy: totalQuantiy,
      type: type,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      code,
      type,
      status,
      destinationId,
      destination,
      temporaryLocationId,
      temporaryLocation,
      totalBox,
      notes,
      totalItems,
      totalQuantiy,
    ];
  }
}
