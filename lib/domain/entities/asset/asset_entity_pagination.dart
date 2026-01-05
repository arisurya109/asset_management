// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:equatable/equatable.dart';

class AssetEntityPagination extends Equatable {
  int? totalData;
  int? currentPage;
  int? lastPage;
  int? limit;
  List<AssetEntity>? assets;

  AssetEntityPagination({
    this.totalData,
    this.currentPage,
    this.lastPage,
    this.limit,
    this.assets,
  });

  @override
  List<Object?> get props => [totalData, currentPage, lastPage, limit, assets];
}
