// ignore_for_file: must_be_immutable, depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class AssetMaster extends Equatable {
  int? id;
  String? name;
  String? type;

  AssetMaster({this.id, this.name, this.type});

  @override
  List<Object?> get props => [id, name, type];
}
