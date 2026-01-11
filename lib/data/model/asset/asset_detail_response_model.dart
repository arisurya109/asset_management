// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/data/model/asset/asset_detail_model.dart';
import 'package:asset_management/data/model/asset/asset_model.dart';
import 'package:asset_management/domain/entities/asset/asset_detail_response.dart';
import 'package:equatable/equatable.dart';

class AssetDetailResponseModel extends Equatable {
  AssetsModel? asset;
  List<AssetDetailModel>? history;

  AssetDetailResponseModel({this.asset, this.history});

  factory AssetDetailResponseModel.fromMap(Map<String, dynamic> map) {
    return AssetDetailResponseModel(
      asset: AssetsModel.fromJson(map),
      history: map['transactions'] != null
          ? (map['transactions'] as List)
                .map(
                  (e) => AssetDetailModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  AssetDetailResponse toEntity() {
    return AssetDetailResponse(
      asset: asset?.toEntity(),
      history: history?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [asset, history];
}
