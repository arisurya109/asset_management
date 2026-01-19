// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:asset_management/domain/entities/picking/picking_detail.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PickingDetailResponse extends Equatable {
  Picking? pickingHeader;
  List<PickingDetail>? items;

  PickingDetailResponse({this.pickingHeader, this.items});

  @override
  List<Object?> get props => [pickingHeader, items];
}
