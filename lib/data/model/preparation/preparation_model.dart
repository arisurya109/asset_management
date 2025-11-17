// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls

import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationModel extends Equatable {
  int? id;
  String? preparationCode;
  int? destinationId;
  String? destination;
  int? assignedId;
  String? assigned;
  int? temporaryLocationId;
  String? temporaryLocation;
  int? totalBox;
  String? status;
  String? notes;
  int? createdById;
  String? createdBy;
  int? updatedById;
  String? updatedBy;

  PreparationModel({
    this.id,
    this.preparationCode,
    this.destinationId,
    this.destination,
    this.assignedId,
    this.assigned,
    this.temporaryLocationId,
    this.temporaryLocation,
    this.totalBox,
    this.status,
    this.notes,
    this.createdById,
    this.createdBy,
    this.updatedById,
    this.updatedBy,
  });

  @override
  List<Object?> get props {
    return [
      id,
      preparationCode,
      destinationId,
      destination,
      assignedId,
      assigned,
      temporaryLocationId,
      temporaryLocation,
      totalBox,
      status,
      notes,
      createdById,
      createdBy,
      updatedById,
      updatedBy,
    ];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'destination_id': destinationId,
      'assigned_id': assignedId,
      'preparation_code': preparationCode,
      'temporary_location_id': temporaryLocationId,
      'total_box': totalBox,
      'status': status,
      'notes': notes,
    };
  }

  factory PreparationModel.fromJson(Map<String, dynamic> map) {
    return PreparationModel(
      id: map['id'] != null ? map['id'] as int : null,
      preparationCode: map['preparation_code'] != null
          ? map['preparation_code'] as String
          : null,
      destinationId: map['destination']['id'] != null
          ? map['destination']['id'] as int
          : null,
      destination: map['destination']['name'] != null
          ? map['destination']['name'] as String
          : null,
      assignedId: map['assigned']['id'] != null
          ? map['assigned']['id'] as int
          : null,
      assigned: map['assigned']['name'] != null
          ? map['assigned']['name'] as String
          : null,
      temporaryLocationId: map['temporary_location']['id'] != null
          ? map['temporary_location']['id'] as int
          : null,
      temporaryLocation: map['temporary_location']['name'] != null
          ? map['temporary_location']['name'] as String
          : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      createdById: map['created_by']['id'] != null
          ? map['created_by']['id'] as int
          : null,
      createdBy: map['created_by']['name'] != null
          ? map['created_by']['name'] as String
          : null,
      updatedById: map['updated_by']['id'] != null
          ? map['updated_by']['id'] as int
          : null,
      updatedBy: map['updated_by']['name'] != null
          ? map['updated_by']['name'] as String
          : null,
    );
  }

  factory PreparationModel.fromEntity(Preparation params) {
    return PreparationModel(
      id: params.id,
      assigned: params.assigned,
      assignedId: params.assignedId,
      createdBy: params.createdBy,
      createdById: params.createdById,
      destination: params.destination,
      destinationId: params.destinationId,
      notes: params.notes,
      preparationCode: params.preparationCode,
      status: params.status,
      temporaryLocation: params.temporaryLocation,
      temporaryLocationId: params.temporaryLocationId,
      totalBox: params.totalBox,
      updatedBy: params.updatedBy,
      updatedById: params.updatedById,
    );
  }

  Preparation toEntity() {
    return Preparation(
      id: id,
      assigned: assigned,
      assignedId: assignedId,
      createdBy: createdBy,
      createdById: createdById,
      destination: destination,
      destinationId: destinationId,
      notes: notes,
      preparationCode: preparationCode,
      status: status,
      temporaryLocation: temporaryLocation,
      temporaryLocationId: temporaryLocationId,
      totalBox: totalBox,
      updatedBy: updatedBy,
      updatedById: updatedById,
    );
  }
}
