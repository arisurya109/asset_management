// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:equatable/equatable.dart';

class PreparationDetailResponse extends Equatable {
  Preparation? preparation;
  List<PreparationDetail>? preparationDetail;

  PreparationDetailResponse({this.preparation, this.preparationDetail});

  @override
  List<Object?> get props => [preparation, preparationDetail];
}
