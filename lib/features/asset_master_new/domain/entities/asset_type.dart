// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class AssetType extends Equatable {
  int? id;
  String? name;

  AssetType({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
