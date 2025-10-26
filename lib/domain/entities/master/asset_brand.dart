// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AssetBrand extends Equatable {
  int? id;
  String? name;
  String? init;

  AssetBrand({this.id, this.name, this.init});

  @override
  List<Object?> get props => [id, name, init];
}
