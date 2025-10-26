part of 'master_bloc.dart';

class MasterEvent extends Equatable {
  const MasterEvent();

  @override
  List<Object> get props => [];
}

class OnInitializeMasterEvent extends MasterEvent {}

class OnFindAllBrandEvent extends MasterEvent {}

class OnFindAllCategoryEvent extends MasterEvent {}

class OnFindAllModelEvent extends MasterEvent {}

class OnFindAllTypesEvent extends MasterEvent {}

class OnFindAllLocationEvent extends MasterEvent {}

class OnFindAllVendorEvent extends MasterEvent {}

class OnCreateBrandEvent extends MasterEvent {
  final AssetBrand params;

  const OnCreateBrandEvent(this.params);
}

class OnCreateCategoryEvent extends MasterEvent {
  final AssetCategory params;

  const OnCreateCategoryEvent(this.params);
}

class OnCreateModelEvent extends MasterEvent {
  final AssetModel params;

  const OnCreateModelEvent(this.params);
}

class OnCreateTypeEvent extends MasterEvent {
  final AssetType params;

  const OnCreateTypeEvent(this.params);
}

class OnCreateLocationEvent extends MasterEvent {
  final Location params;

  const OnCreateLocationEvent(this.params);
}

class OnCreateVendorEvent extends MasterEvent {
  final Vendor params;

  const OnCreateVendorEvent(this.params);
}
