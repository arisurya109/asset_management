// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/data/model/picking/picking_detail_model.dart';
import 'package:asset_management/data/model/picking/picking_model.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_response.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingDetailResponseModel extends Equatable {
  PickingModel? pickingHeader;
  List<PickingDetailModel>? items;

  PickingDetailResponseModel({this.pickingHeader, this.items});

  factory PickingDetailResponseModel.fromJson(Map<String, dynamic> map) {
    return PickingDetailResponseModel(
      pickingHeader: PickingModel.fromJson(map),
      items: map['items'] != null
          ? (map['items'] as List?)
                    ?.map(
                      (e) => PickingDetailModel.fromJson(
                        e as Map<String, dynamic>,
                      ),
                    )
                    .toList() ??
                []
          : null,
    );
  }

  PickingDetailResponse toEntity() {
    return PickingDetailResponse(
      pickingHeader: pickingHeader?.toEntity(),
      items: items?.map((e) => e.toEntity()).toList() ?? [],
    );
  }

  @override
  List<Object?> get props => [pickingHeader, items];
}
