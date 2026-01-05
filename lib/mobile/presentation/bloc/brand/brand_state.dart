// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'brand_bloc.dart';

enum StatusBrand { initial, loading, failure, success }

class BrandState extends Equatable {
  StatusBrand? status;
  List<AssetBrand>? brands;
  String? message;

  BrandState({this.status = StatusBrand.initial, this.brands, this.message});

  @override
  List<Object?> get props => [status, brands, message];

  BrandState copyWith({
    StatusBrand? status,
    List<AssetBrand>? brands,
    bool clearAll = false,
    String? message,
  }) {
    return BrandState(
      status: status ?? this.status,
      brands: clearAll ? null : (brands ?? this.brands),
      message: message ?? this.message,
    );
  }
}
