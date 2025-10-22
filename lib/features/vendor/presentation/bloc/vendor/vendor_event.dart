part of 'vendor_bloc.dart';

class VendorEvent extends Equatable {
  const VendorEvent();

  @override
  List<Object> get props => [];
}

class OnCreateVendor extends VendorEvent {
  final Vendor params;

  const OnCreateVendor(this.params);
}

class OnUpdateVendor extends VendorEvent {
  final Vendor params;

  const OnUpdateVendor(this.params);
}

class OnGetAllVendor extends VendorEvent {}
