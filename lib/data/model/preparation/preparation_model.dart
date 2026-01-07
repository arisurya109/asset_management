// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:asset_management/domain/entities/preparation/preparation.dart';

// ignore: must_be_immutable
class PreparationModel extends Equatable {
  int? id;
  String? code;
  String? type;
  String? status;
  int? destinationId;
  String? destination;
  int? temporaryLocationId;
  String? temporaryLocation;
  int? createdId;
  String? created;
  int? workerId;
  String? worker;
  int? approvedId;
  String? approved;
  int? totalBox;
  String? notes;
  DateTime? createdAt;

  PreparationModel({
    this.id,
    this.code,
    this.type,
    this.status,
    this.destinationId,
    this.destination,
    this.temporaryLocationId,
    this.temporaryLocation,
    this.createdId,
    this.created,
    this.workerId,
    this.worker,
    this.approvedId,
    this.approved,
    this.totalBox,
    this.notes,
    this.createdAt,
  });

  factory PreparationModel.fromEntity(Preparation params) {
    return PreparationModel(
      id: params.id,
      code: params.code,
      type: params.type,
      status: params.status,
      destination: params.destination,
      destinationId: params.destinationId,
      temporaryLocation: params.temporaryLocation,
      temporaryLocationId: params.temporaryLocationId,
      createdId: params.createdId,
      created: params.created,
      worker: params.worker,
      workerId: params.workerId,
      approved: params.approved,
      approvedId: params.approvedId,
      createdAt: params.createdAt,
      notes: params.notes,
      totalBox: params.totalBox,
    );
  }

  Preparation toEntity() {
    return Preparation(
      id: id,
      code: code,
      type: type,
      status: status,
      destination: destination,
      destinationId: destinationId,
      temporaryLocation: temporaryLocation,
      temporaryLocationId: temporaryLocationId,
      created: created,
      createdId: createdId,
      createdAt: createdAt,
      approved: approved,
      approvedId: approvedId,
      notes: notes,
      totalBox: totalBox,
      worker: worker,
      workerId: workerId,
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
      createdId,
      created,
      workerId,
      worker,
      approvedId,
      approved,
      totalBox,
      notes,
      createdAt,
    ];
  }

  Map<String, dynamic> createToJson() {
    return <String, dynamic>{
      'type': type,
      'destination_id': destinationId,
      'worker_id': workerId,
      'approved_id': approvedId,
      'notes': notes,
    };
  }

  factory PreparationModel.fromJson(Map<String, dynamic> map) {
    return PreparationModel(
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
      createdId: map['created']['id'] != null
          ? map['created']['id'] as int
          : null,
      created: map['created']['name'] != null
          ? map['created']['name'] as String
          : null,
      workerId: map['worker']['id'] != null ? map['worker']['id'] as int : null,
      worker: map['worker']['name'] != null
          ? map['worker']['name'] as String
          : null,
      approvedId: map['approved']['id'] != null
          ? map['approved']['id'] as int
          : null,
      approved: map['approved']['name'] != null
          ? map['approved']['name'] as String
          : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
    );
  }
}
