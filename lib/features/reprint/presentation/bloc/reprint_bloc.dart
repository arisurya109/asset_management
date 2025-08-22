// ignore_for_file: depend_on_referenced_packages

import '../../domain/usecases/reprint_asset_by_asset_id_use_case.dart';
import '../../domain/usecases/reprint_asset_by_serial_number_use_case.dart';
import '../../domain/usecases/reprint_location_use_case.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'reprint_event.dart';
part 'reprint_state.dart';

class ReprintBloc extends Bloc<ReprintEvent, ReprintState> {
  final ReprintAssetByAssetIdUseCase _byId;
  final ReprintAssetBySerialNumberUseCase _bySn;
  final ReprintLocationUseCase _location;

  ReprintBloc(this._byId, this._bySn, this._location) : super(ReprintState()) {
    on<OnReprintAssetById>(_byAssetId);
    on<OnReprintAssetBySerialNumber>(_bySerialNumber);
    on<OnReprintLocation>(_locations);
  }

  void _locations(OnReprintLocation event, Emitter<ReprintState> emit) async {
    emit(state.copyWith(status: StatusReprint.loading));

    final failureOrSuccess = await _location(event.location);

    return failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(status: StatusReprint.failed, message: failure.message),
      ),
      (_) => emit(state.copyWith(status: StatusReprint.success, message: null)),
    );
  }

  void _bySerialNumber(
    OnReprintAssetBySerialNumber event,
    Emitter<ReprintState> emit,
  ) async {
    emit(state.copyWith(status: StatusReprint.loading));

    final failureOrSuccess = await _bySn(event.serialNumber);

    return failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(status: StatusReprint.failed, message: failure.message),
      ),
      (_) => emit(state.copyWith(status: StatusReprint.success, message: null)),
    );
  }

  void _byAssetId(OnReprintAssetById event, Emitter<ReprintState> emit) async {
    emit(state.copyWith(status: StatusReprint.loading));

    final failureOrSuccess = await _byId(event.assetId);

    return failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(status: StatusReprint.failed, message: failure.message),
      ),
      (_) => emit(state.copyWith(status: StatusReprint.success, message: null)),
    );
  }
}
