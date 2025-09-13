// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import 'package:asset_management/core/utils/enum.dart';

// ignore: must_be_immutable
class AssetCount extends Equatable {
  int? id;
  String? title;
  String? description;
  String? countCode;
  DateTime? countDate;
  StatusCount? status;

  AssetCount({
    this.id,
    this.title,
    this.description,
    this.countCode,
    this.countDate,
    this.status,
  });
  @override
  List<Object?> get props => [
    id,
    title,
    description,
    countCode,
    countDate,
    status,
  ];
}
