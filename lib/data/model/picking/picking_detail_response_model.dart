// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/data/model/picking/picking_detail_model.dart';
import 'package:asset_management/data/model/picking/picking_model.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_response.dart';
import 'package:equatable/equatable.dart';

class PickingDetailResponseModel extends Equatable {
  PickingModel? picking;
  List<PickingDetailModel>? pickingDetail;

  PickingDetailResponseModel({this.picking, this.pickingDetail});

  factory PickingDetailResponseModel.fromMap(Map<String, dynamic> map) {
    return PickingDetailResponseModel(
      picking: PickingModel.fromJson(map),
      pickingDetail: map['items'] != null
          ? (map['items'] as List)
                .map(
                  (e) => PickingDetailModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }

  PickingDetailResponse toEntity() {
    return PickingDetailResponse(
      picking: picking?.toEntity(),
      pickingDetail: pickingDetail?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [picking, pickingDetail];
}
