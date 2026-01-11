// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:asset_management/domain/entities/picking/picking_detail.dart';
import 'package:equatable/equatable.dart';

class PickingDetailResponse extends Equatable {
  Picking? picking;
  List<PickingDetail>? pickingDetail;

  PickingDetailResponse({this.picking, this.pickingDetail});

  @override
  List<Object?> get props => [picking, pickingDetail];
}
