// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingModel extends Equatable {
  int? id;
  String? code;
  String? status;
  int? destinationId;
  String? destination;
  int? destinationCode;
  String? destinationInit;
  String? notes;

  PickingModel({
    this.id,
    this.code,
    this.status,
    this.destinationId,
    this.destination,
    this.destinationCode,
    this.destinationInit,
    this.notes,
  });

  factory PickingModel.fromJson(Map<String, dynamic> map) {
    return PickingModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      destinationId: map['destination']['id'] != null
          ? map['destination']['id'] as int
          : null,
      destination: map['destination']['name'] != null
          ? map['destination']['name'] as String
          : null,
      destinationCode: map['destination']['code'] != null
          ? map['destination']['code'] as int
          : null,
      destinationInit: map['destination']['init'] != null
          ? map['destination']['init'] as String
          : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  Picking toEntity() {
    return Picking(
      id: id,
      code: code,
      destination: destination,
      destinationCode: destinationCode,
      destinationId: destinationId,
      destinationInit: destinationInit,
      notes: notes,
      status: status,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      code,
      destinationCode,
      destinationInit,
      status,
      destinationId,
      destination,
      notes,
    ];
  }
}
