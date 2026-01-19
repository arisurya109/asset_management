// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/data/model/preparation/preparation_document_item_model.dart';
import 'package:asset_management/domain/entities/preparation/preparation_document.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PreparationDocumentModel extends Equatable {
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
  List<PreparationDocumentItemModel>? items;

  PreparationDocumentModel({
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

  PreparationDocument toEntity() {
    return PreparationDocument(
      id: id,
      code: code,
      destination: destination,
      destinationCode: destinationCode,
      destinationInit: destinationInit,
      created: created,
      createdSignature: createdSignature,
      approved: approved,
      approvedSignature: approvedSignature,
      worker: worker,
      workerSignature: workerSignature,
      totalBox: totalBox,
      notes: notes,
      items: items?.map((e) => e.toEntity()).toList() ?? [],
    );
  }

  factory PreparationDocumentModel.fromJson(Map<String, dynamic> map) {
    return PreparationDocumentModel(
      id: map['id'] != null ? map['id'] as int : null,
      code: map['code'] != null ? map['code'] as String : null,
      destination: map['destination']['name'] != null
          ? map['destination']['name'] as String
          : null,
      destinationInit: map['destination']['init'] != null
          ? map['destination']['init'] as String
          : null,
      destinationCode: map['destination']['code'] != null
          ? map['destination']['code'] as int
          : null,
      created: map['created']['name'] != null
          ? map['created']['name'] as String
          : null,
      createdSignature: map['created']['signature'] != null
          ? map['created']['signature'] as String
          : null,
      approved: map['approved']['name'] != null
          ? map['approved']['name'] as String
          : null,
      approvedSignature: map['approved']['signature'] != null
          ? map['approved']['signature'] as String
          : null,
      worker: map['worker']['name'] != null
          ? map['worker']['name'] as String
          : null,
      workerSignature: map['worker']['signature'] != null
          ? map['worker']['signature'] as String
          : null,
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      items: map['items'] != null
          ? (map['items'] as List)
                .map(
                  (e) => PreparationDocumentItemModel.fromJson(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList()
          : null,
    );
  }

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
