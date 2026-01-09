// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors_first

import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:asset_management/domain/entities/preparation/preparation_pagination.dart';
import 'package:equatable/equatable.dart';

class PreparationPaginationModel extends Equatable {
  PreparationPaginationModel({
    this.totalData,
    this.currentPage,
    this.lastPage,
    this.limit,
    this.preparations,
  });

  int? totalData;
  int? currentPage;
  int? lastPage;
  int? limit;
  List<PreparationModel>? preparations;

  factory PreparationPaginationModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? baseData =
        json['data'] as Map<String, dynamic>?;

    final metadata = baseData?['metadata'] as Map<String, dynamic>?;

    return PreparationPaginationModel(
      totalData: metadata?['total_data'] as int? ?? 0,
      currentPage: metadata?['current_page'] as int? ?? 1,
      lastPage: metadata?['last_page'] as int? ?? 1,
      limit: metadata?['limit'] as int? ?? 10,
      // List data juga diambil dari baseData?['data']
      preparations:
          (baseData?['data'] as List?)
              ?.map((e) => PreparationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  PreparationPagination toEntity() {
    return PreparationPagination(
      totalData: totalData,
      currentPage: currentPage,
      lastPage: lastPage,
      limit: limit,
      preparations: preparations?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
    totalData,
    currentPage,
    lastPage,
    limit,
    preparations,
  ];
}
