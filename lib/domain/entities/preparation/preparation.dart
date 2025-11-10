// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Preparation extends Equatable {
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

  Preparation({
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

  Preparation copyWith({
    int? id,
    String? preparationCode,
    int? destinationId,
    String? destination,
    int? assignedId,
    String? assigned,
    int? temporaryLocationId,
    String? temporaryLocation,
    int? totalBox,
    String? status,
    String? notes,
    int? createdById,
    String? createdBy,
    int? updatedById,
    String? updatedBy,
  }) {
    return Preparation(
      id: id ?? this.id,
      preparationCode: preparationCode ?? this.preparationCode,
      destinationId: destinationId ?? this.destinationId,
      destination: destination ?? this.destination,
      assignedId: assignedId ?? this.assignedId,
      assigned: assigned ?? this.assigned,
      temporaryLocationId: temporaryLocationId ?? this.temporaryLocationId,
      temporaryLocation: temporaryLocation ?? this.temporaryLocation,
      totalBox: totalBox ?? this.totalBox,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdById: createdById ?? this.createdById,
      createdBy: createdBy ?? this.createdBy,
      updatedById: updatedById ?? this.updatedById,
      updatedBy: updatedBy ?? this.updatedBy,
    );
  }
}
