import 'package:asset_management/domain/entities/preparation/preparation_pagination.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_by_pagination_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preparation_desktop_event.dart';
part 'preparation_desktop_state.dart';

class PreparationDesktopBloc
    extends Bloc<PreparationDesktopEvent, PreparationDesktopState> {
  final FindPreparationByPaginationUseCase _findPreparationPaginationUseCase;
  PreparationDesktopBloc(this._findPreparationPaginationUseCase)
    : super(PreparationDesktopState()) {
    on<OnFindPreparationPaginationEvent>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationDesktop.loading));

      final failureOrPreparations = await _findPreparationPaginationUseCase(
        limit: event.limit,
        page: event.page,
        query: event.query,
      );

      return failureOrPreparations.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationDesktop.failure,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            status: StatusPreparationDesktop.loaded,
            datas: response,
          ),
        ),
      );
    });
  }
}
