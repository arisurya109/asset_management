// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enum.dart';
import '../../domain/entities/asset_count.dart';

// ignore: must_be_immutable
class AssetCountModel extends Equatable {
  int? id;
  String? title;
  String? description;
  String? countCode;
  DateTime? countDate;
  StatusCount? status;

  AssetCountModel({
    this.id,
    this.title,
    this.description,
    this.countCode,
    this.countDate,
    this.status,
  });

  factory AssetCountModel.fromMap(Map<String, dynamic> params) {
    return AssetCountModel(
      id: params['id'],
      title: params['title'],
      description: params['description'],
      countCode: params['count_code'],
      status: params['status'] == 'CREATED'
          ? StatusCount.CREATED
          : params['status'] == 'ONPROCESS'
          ? StatusCount.ONPROCESS
          : StatusCount.COMPLETED,
      countDate: DateTime.parse(params['count_date']),
    );
  }

  factory AssetCountModel.fromEntity(AssetCount params) {
    return AssetCountModel(
      id: params.id,
      title: params.title,
      description: params.description,
      countCode: params.countCode,
      countDate: params.countDate,
      status: params.status,
    );
  }

  AssetCount toEntity() {
    return AssetCount(
      id: id,
      title: title,
      description: description,
      countCode: countCode,
      countDate: countDate,
      status: status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'count_code': countCode,
      'count_date': countDate?.toIso8601String(),
      'status': status,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    countCode,
    countDate,
    status,
  ];
}
