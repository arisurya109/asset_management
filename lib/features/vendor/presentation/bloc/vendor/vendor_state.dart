// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vendor_bloc.dart';

enum StatusVendor { initial, loading, failed, success }

// ignore: must_be_immutable
class VendorState extends Equatable {
  StatusVendor? status;
  List<Vendor>? vendors;
  String? message;

  VendorState({this.status = StatusVendor.initial, this.vendors, this.message});

  @override
  List<Object?> get props => [status, vendors, message];

  VendorState copyWith({
    StatusVendor? status,
    List<Vendor>? vendors,
    String? message,
  }) {
    return VendorState(
      status: status ?? this.status,
      vendors: vendors ?? this.vendors,
      message: message ?? this.message,
    );
  }
}
