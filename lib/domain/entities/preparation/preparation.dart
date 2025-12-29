// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Preparation extends Equatable {
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

  Preparation({
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

  @override
  List<Object?> get props {
    return [
      id,
      code,
      status,
      type,
      destinationId,
      destination,
      totalBox,
      status,
      notes,
      createdBy,
      createdId,
      approvedBy,
      createdId,
      workerId,
      workerBy,
      createdAt,
    ];
  }
}
