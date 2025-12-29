import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preparation_desktop_event.dart';
part 'preparation_desktop_state.dart';

class PreparationDesktopBloc
    extends Bloc<PreparationDesktopEvent, PreparationDesktopState> {
  final FindAllPreparationUseCase _findAllPreparationUseCase;
  PreparationDesktopBloc(this._findAllPreparationUseCase)
    : super(PreparationDesktopState()) {
    on<OnFindAllPreparation>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationDesktop.loading));

      final failureOrPreparations = await _findAllPreparationUseCase();

      return failureOrPreparations.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationDesktop.failure,
            message: failure.message,
          ),
        ),
        (preparations) => emit(
          state.copyWith(
            status: StatusPreparationDesktop.loaded,
            preparations: preparations,
          ),
        ),
      );
    });
    // on<OnFindAllPreparation>((event, emit) async {});
  }
}
