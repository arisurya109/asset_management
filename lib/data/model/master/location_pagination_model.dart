// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors_first

import 'package:asset_management/data/model/master/location_model.dart';
import 'package:asset_management/domain/entities/master/location_pagination.dart';
import 'package:equatable/equatable.dart';

class LocationPaginationModel extends Equatable {
  LocationPaginationModel({
    this.totalData,
    this.currentPage,
    this.lastPage,
    this.limit,
    this.locations,
  });

  int? totalData;
  int? currentPage;
  int? lastPage;
  int? limit;
  List<LocationModel>? locations;

  factory LocationPaginationModel.fromJson(Map<String, dynamic> datas) {
    return LocationPaginationModel(
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
      locations: datas['data'] != null
          ? (datas['data'] as List)
                .map((e) => LocationModel.fromAPI(e as Map<String, dynamic>))
                .toList()
          : [],
    );
  }

  LocationPagination toEntity() {
    return LocationPagination(
      totalData: totalData,
      currentPage: currentPage,
      lastPage: lastPage,
      limit: limit,
      locations: locations?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [
    totalData,
    currentPage,
    lastPage,
    limit,
    locations,
  ];
}
