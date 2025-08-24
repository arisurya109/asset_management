// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../usecases/reprint/reprint_asset_id_by_asset_id_use_case.dart';
import '../../usecases/reprint/reprint_location_use_case.dart';
import '../../core/utils/enum.dart';

part 'reprint_event.dart';
part 'reprint_state.dart';

class ReprintBloc extends Bloc<ReprintEvent, ReprintState> {
  final ReprintAssetIdByAssetIdUseCase _reprintAssetIdByAssetIdUseCase;
  final ReprintLocationUseCase _reprintLocationUseCase;

  ReprintBloc(
    this._reprintAssetIdByAssetIdUseCase,
    this._reprintLocationUseCase,
  ) : super(ReprintState()) {
    on<OnReprintAssetIdByAssetId>(_reprintAssetIdByAssetId);
    on<OnReprintLocation>(_reprintLocation);
    on<OnSetStatusInitial>(_setStatusInitial);
  }

  void _reprintAssetIdByAssetId(
    OnReprintAssetIdByAssetId event,
    Emitter<ReprintState> emit,
  ) async {
    emit(state.copyWith(status: StatusReprint.loading));

    final failureOrSuccess = await _reprintAssetIdByAssetIdUseCase(
      event.assetId,
    );

    return failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(status: StatusReprint.failed, message: failure.message),
      ),
      (ifRight) => emit(state.copyWith(status: StatusReprint.success)),
    );
  }

  void _reprintLocation(
    OnReprintLocation event,
    Emitter<ReprintState> emit,
  ) async {
    emit(state.copyWith(status: StatusReprint.loading));

    final failureOrSuccess = await _reprintLocationUseCase(event.location);

    return failureOrSuccess.fold(
      (failure) => emit(
        state.copyWith(status: StatusReprint.failed, message: failure.message),
      ),
      (ifRight) => emit(state.copyWith(status: StatusReprint.success)),
    );
  }

  void _setStatusInitial(OnSetStatusInitial event, Emitter<ReprintState> emit) {
    emit(state.copyWith(status: StatusReprint.initial));
  }
}
