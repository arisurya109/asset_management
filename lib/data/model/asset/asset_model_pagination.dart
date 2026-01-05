// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management/domain/entities/asset/asset_entity_pagination.dart';
import 'package:equatable/equatable.dart';
import 'package:asset_management/data/model/asset/asset_model.dart';

class AssetModelPagination extends Equatable {
  int? totalData;
  int? currentPage;
  int? lastPage;
  int? limit;
  List<AssetsModel>? assets;

  AssetModelPagination({
    this.totalData,
    this.currentPage,
    this.lastPage,
    this.limit,
    this.assets,
  });

  @override
  List<Object?> get props => [totalData, currentPage, lastPage, limit, assets];

  factory AssetModelPagination.fromJson(Map<String, dynamic> map) {
    return AssetModelPagination(
      totalData: map['metadata']['total_data'] != null
          ? map['metadata']['total_data'] as int
          : null,
      currentPage: map['metadata']['current_page'] != null
          ? map['metadata']['current_page'] as int
          : null,
      lastPage: map['metadata']['last_page'] != null
          ? map['metadata']['last_page'] as int
          : null,
      limit: map['metadata']['limit'] != null
          ? map['metadata']['limit'] as int
          : null,
      assets: map['data'] != null
          ? (map['data'] as List).map((e) => AssetsModel.fromJson(e)).toList()
          : [],
    );
  }

  AssetEntityPagination toEntity() {
    return AssetEntityPagination(
      totalData: totalData,
      currentPage: currentPage,
      limit: limit,
      lastPage: lastPage,
      assets: assets?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
