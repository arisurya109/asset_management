// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Picking extends Equatable {
  int? id;
  String? code;
  String? status;
  int? destinationId;
  String? destination;
  int? destinationCode;
  String? destinationInit;
  String? notes;

  Picking({
    this.id,
    this.code,
    this.status,
    this.destinationId,
    this.destination,
    this.destinationCode,
    this.destinationInit,
    this.notes,
  });

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
