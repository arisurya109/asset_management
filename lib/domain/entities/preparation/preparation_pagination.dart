// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:equatable/equatable.dart';

class PreparationPagination extends Equatable {
  int? totalData;
  int? currentPage;
  int? lastPage;
  int? limit;
  List<Preparation>? preparations;

  PreparationPagination({
    this.totalData,
    this.currentPage,
    this.lastPage,
    this.limit,
    this.preparations,
  });

  @override
  List<Object?> get props => [
    totalData,
    currentPage,
    lastPage,
    limit,
    preparations,
  ];
}
