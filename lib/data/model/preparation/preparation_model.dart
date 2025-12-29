// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynam

import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationModel extends Equatable {
  int? id;
  String? code;
  String? type;
  String? status;
  int? destinationId;
  String? destination;
  int? createdId;
  String? createdBy;
  int? workerId;
  String? workerBy;
  int? approvedId;
  String? approvedBy;
  int? locationId;
  String? location;
  int? totalBox;
  String? notes;
  String? createdAt;

  PreparationModel({
    this.id,
    this.code,
    this.type,
    this.status,
    this.destinationId,
    this.destination,
    this.createdId,
    this.createdBy,
    this.workerId,
    this.workerBy,
    this.approvedId,
    this.approvedBy,
    this.locationId,
    this.location,
    this.totalBox,
    this.notes,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'destination_id': destinationId,
      'worker_id': workerId,
      'location_id': locationId,
      'total_box': totalBox,
      'status': status,
      'notes': notes,
      'type': type,
      'created_id': createdId,
      'approved_id': approvedId,
    };
  }

  factory PreparationModel.fromJSON(Map<String, dynamic> map) {
    return PreparationModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      destinationId: map['destination']['id'] != null
          ? map['destination']['id'] as int
          : null,
      destination: map['destination']['name'] != null
          ? map['destination']['name'] as String
          : null,
      createdId: map['created']['id'] != null
          ? map['created']['id'] as int
          : null,
      createdBy: map['created']['name'] != null
          ? map['created']['name'] as String
          : null,
      workerId: map['worker']['name'] != null
          ? map['worker']['name'] as int
          : null,
      workerBy: map['worker']['name'] != null
          ? map['worker']['name'] as String
          : null,
      approvedId: map['approved']['id'] != null
          ? map['approved']['id'] as int
          : null,
      approvedBy: map['approved']['name'] != null
          ? map['approved']['name'] as String
          : null,
      locationId: map['location']['id'] != null
          ? map['location']['id'] as int
          : null,
      location: map['location']['name'] != null
          ? map['location']['name'] as String
          : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      createdAt: map['created_at'] != null ? map['created_at'] as String : null,
    );
  }

  factory PreparationModel.fromEntity(Preparation params) {
    return PreparationModel(
      id: params.id,
      code: params.code,
      status: params.status,
      type: params.type,
      createdId: params.createdId,
      createdBy: params.createdBy,
      workerId: params.workerId,
      workerBy: params.workerBy,
      approvedId: params.approvedId,
      approvedBy: params.approvedBy,
      destinationId: params.destinationId,
      destination: params.destination,
      locationId: params.locationId,
      location: params.location,
      notes: params.notes,
      totalBox: params.totalBox,
      createdAt: params.createdAt,
    );
  }

  Preparation toEntity() {
    return Preparation(
      id: id,
      code: code,
      status: status,
      type: type,
      createdId: createdId,
      createdBy: createdAt,
      workerBy: workerBy,
      workerId: workerId,
      approvedBy: approvedBy,
      approvedId: approvedId,
      destination: destination,
      destinationId: destinationId,
      location: location,
      locationId: locationId,
      notes: notes,
      createdAt: createdAt,
      totalBox: totalBox,
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
      createdId,
      createdBy,
      workerId,
      workerBy,
      approvedId,
      approvedBy,
      locationId,
      location,
      totalBox,
      notes,
      createdAt,
    ];
  }
}
