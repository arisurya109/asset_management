// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/domain/entities/preparation/preparation_document_item.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDocument extends Equatable {
  int? id;
  String? code;
  String? destination;
  String? destinationInit;
  int? destinationCode;
  String? created;
  String? createdSignature;
  String? approved;
  String? approvedSignature;
  String? worker;
  String? workerSignature;
  int? totalBox;
  String? notes;
  List<PreparationDocumentItem>? items;

  PreparationDocument({
    this.id,
    this.code,
    this.destination,
    this.destinationInit,
    this.destinationCode,
    this.created,
    this.createdSignature,
    this.approved,
    this.approvedSignature,
    this.worker,
    this.workerSignature,
    this.totalBox,
    this.notes,
    this.items,
  });

  @override
  List<Object?> get props {
    return [
      id,
      code,
      destination,
      destinationInit,
      destinationCode,
      created,
      createdSignature,
      approved,
      approvedSignature,
      worker,
      workerSignature,
      totalBox,
      notes,
      items,
    ];
  }
}
