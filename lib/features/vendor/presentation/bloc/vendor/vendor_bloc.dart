import 'package:asset_management/features/vendor/vendor_export.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vendor_event.dart';
part 'vendor_state.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final CreateVendorUseCase _createVendorUseCase;
  final UpdateVendorUseCase _updateVendorUseCase;
  final FindAllVendorUseCase _findAllVendorUseCase;

  VendorBloc(
    this._createVendorUseCase,
    this._updateVendorUseCase,
    this._findAllVendorUseCase,
  ) : super(VendorState()) {
    on<OnCreateVendor>((event, emit) async {
      emit(state.copyWith(status: StatusVendor.loading));

      final failureOrVendor = await _createVendorUseCase(event.params);

      return failureOrVendor.fold(
        (failure) => emit(
          state.copyWith(status: StatusVendor.failed, message: failure.message),
        ),
        (vendor) => emit(
          state.copyWith(
            status: StatusVendor.success,
            vendors: state.vendors?..add(vendor),
          ),
        ),
      );
    });

    on<OnUpdateVendor>((event, emit) async {
      emit(state.copyWith(status: StatusVendor.loading));

      final failureOrVendor = await _updateVendorUseCase(event.params);

      return failureOrVendor.fold(
        (failure) => emit(
          state.copyWith(status: StatusVendor.failed, message: failure.message),
        ),
        (vendor) => emit(
          state.copyWith(
            status: StatusVendor.success,
            vendors: state.vendors
              ?..removeWhere((element) => element.id == vendor.id)
              ..add(vendor)
              ..sort((a, b) => a.id!.compareTo(b.id!)),
          ),
        ),
      );
    });

    on<OnGetAllVendor>((event, emit) async {
      emit(state.copyWith(status: StatusVendor.loading));

      final failureOrVendor = await _findAllVendorUseCase();

      return failureOrVendor.fold(
        (failure) => emit(
          state.copyWith(status: StatusVendor.failed, message: failure.message),
        ),
        (vendor) =>
            emit(state.copyWith(status: StatusVendor.success, vendors: vendor)),
      );
    });
  }
}
