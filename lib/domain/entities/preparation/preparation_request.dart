// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/core/core.dart';
import 'package:equatable/equatable.dart';

class PreparationRequest extends Equatable {
  int? id;
  String? type;
  String? status;
  int? destination;
  int? created;
  int? worker;
  int? approved;
  String? notes;

  PreparationRequest({
    this.id,
    this.type,
    this.status,
    this.destination,
    this.created,
    this.worker,
    this.approved,
    this.notes,
  });

  Map<String, dynamic> toJsonCreate() {
    return {
      'type': type,
      'destination': destination,
      'approved': approved,
      'worker': worker,
      'notes': notes,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {'status': status};
  }

  String? validateCreateRequest() {
    if (!type.isFilled()) {
      return 'Type cannot be empty';
    } else if (destination == null) {
      return 'Destination cannot be empty';
    } else if (approved == null) {
      return 'Approved cannot be empty';
    } else if (worker == null) {
      return 'Worker cannot be empty';
    } else {
      return null;
    }
  }

  String? validateUpdateRequest() {
    if (id == null) {
      return 'Id cannot be empty';
    } else if (!status.isFilled()) {
      return 'Status cannot be empty';
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props {
    return [id, type, status, destination, created, worker, approved, notes];
  }
}
