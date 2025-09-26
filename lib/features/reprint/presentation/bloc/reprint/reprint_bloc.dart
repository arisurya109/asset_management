// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/usecases.dart';
import 'package:bloc/bloc.dart';

part 'reprint_event.dart';
part 'reprint_state.dart';

class ReprintBloc extends Bloc<ReprintEvent, ReprintState> {
  final ReprintAssetIdNormalUseCase _normalAssetId;
  final ReprintAssetIdLargeUseCase _largeAssetId;
  final ReprintLocationUseCase _location;
  ReprintBloc(this._normalAssetId, this._largeAssetId, this._location)
    : super(ReprintState()) {
    on<OnSetStatusInitial>((event, emit) {
      emit(state.copyWith(status: StatusReprint.initial));
    });

    on<OnReprintAssetIdNormal>((event, emit) async {
      emit(state.copyWith(status: StatusReprint.loading));

      final failureOrSuccess = await _normalAssetId(event.params);

      return failureOrSuccess.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusReprint.failed,
            message: failure.message,
          ),
        ),
        (_) => emit(state.copyWith(status: StatusReprint.success)),
      );
    });

    on<OnReprintAssetIdLarge>((event, emit) async {
      emit(state.copyWith(status: StatusReprint.loading));

      final failureOrSuccess = await _largeAssetId(event.params);

      return failureOrSuccess.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusReprint.failed,
            message: failure.message,
          ),
        ),
        (_) => emit(state.copyWith(status: StatusReprint.success)),
      );
    });
    on<OnReprintLocation>((event, emit) async {
      emit(state.copyWith(status: StatusReprint.loading));

      final failureOrSuccess = await _location(event.params);

      return failureOrSuccess.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusReprint.failed,
            message: failure.message,
          ),
        ),
        (_) => emit(state.copyWith(status: StatusReprint.success)),
      );
    });
  }
}
