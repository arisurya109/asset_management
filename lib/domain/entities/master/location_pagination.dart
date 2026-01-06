// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:asset_management/domain/entities/master/location.dart';
import 'package:equatable/equatable.dart';

class LocationPagination extends Equatable {
  int? totalData;
  int? currentPage;
  int? lastPage;
  int? limit;
  List<Location>? locations;

  LocationPagination({
    this.totalData,
    this.currentPage,
    this.lastPage,
    this.limit,
    this.locations,
  });

  @override
  List<Object?> get props => [
    totalData,
    currentPage,
    lastPage,
    limit,
    locations,
  ];
}
