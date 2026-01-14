import 'package:asset_management/domain/entities/preparation/preparation_pagination.dart';
import 'package:asset_management/domain/entities/preparation/preparation_request.dart';
import 'package:asset_management/domain/usecases/preparation/create_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_by_pagination_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/update_preparation_status_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preparation_desktop_event.dart';
part 'preparation_desktop_state.dart';

class PreparationDesktopBloc
    extends Bloc<PreparationDesktopEvent, PreparationDesktopState> {
  final FindPreparationByPaginationUseCase _findPreparationPaginationUseCase;
  final CreatePreparationUseCase _createPreparationUseCase;
  final UpdatePreparationStatusUseCase _updatePreparationStatusUseCase;

  PreparationDesktopBloc(
    this._findPreparationPaginationUseCase,
    this._createPreparationUseCase,
    this._updatePreparationStatusUseCase,
  ) : super(PreparationDesktopState()) {
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

    on<OnCreatePreparationEvent>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationDesktop.loading));

      final failureOrPreparation = await _createPreparationUseCase(
        params: event.params,
      );

      return failureOrPreparation.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationDesktop.failure,
            message: failure.message,
          ),
        ),
        (preparation) => emit(
          state.copyWith(
            status: StatusPreparationDesktop.addSuccess,
            message: 'Successfully create ${preparation.code}',
          ),
        ),
      );
    });

    on<OnUpdatePreparationStatus>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationDesktop.loading));

      final failureOrPreparationDetails = await _updatePreparationStatusUseCase(
        params: event.params,
      );

      return failureOrPreparationDetails.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationDesktop.failure,
            message: failure.message,
          ),
        ),
        (response) async {
          final failureOrPreparations = await _findPreparationPaginationUseCase(
            limit: 10,
            page: 1,
          );

          return failureOrPreparations.fold(
            (_) {},
            (_) => emit(
              state.copyWith(
                status: StatusPreparationDesktop.updateSuccess,
                message: 'Successfully ${response.status} ${response.code}',
              ),
            ),
          );
        },
      );
    });
  }
}
