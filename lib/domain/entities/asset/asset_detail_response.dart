// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:asset_management/domain/entities/asset/asset_detail.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:equatable/equatable.dart';

class AssetDetailResponse extends Equatable {
  AssetEntity? asset;
  List<AssetDetail>? history;

  AssetDetailResponse({this.asset, this.history});

  @override
  List<Object?> get props => [asset, history];
}
