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

  factory PreparationPaginationModel.fromJson(Map<String, dynamic> datas) {
    return PreparationPaginationModel(
      totalData: datas['metadata']['total_data'] != null
          ? datas['metadata']['total_data'] as int
          : null,
      currentPage: datas['metadata']['current_page'] != null
          ? datas['metadata']['current_page'] as int
          : null,
      lastPage: datas['metadata']['last_page'] != null
          ? datas['metadata']['last_page'] as int
          : null,
      limit: datas['metadata']['limit'] != null
          ? datas['metadata']['limit'] as int
          : null,
      preparations: datas['data'] != null
          ? (datas['data'] as List)
                .map(
                  (e) => PreparationModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : [],
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
