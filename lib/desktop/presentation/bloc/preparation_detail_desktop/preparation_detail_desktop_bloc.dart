import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail_response.dart';
import 'package:asset_management/domain/usecases/preparation/add_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/get_preparation_details_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preparation_detail_desktop_event.dart';
part 'preparation_detail_desktop_state.dart';

class PreparationDetailDesktopBloc
    extends Bloc<PreparationDetailDesktopEvent, PreparationDetailDesktopState> {
  final AddPreparationDetailUseCase _addPreparationDetailUseCase;
  final GetPreparationDetailsUseCase _getPreparationDetailsUseCase;

  PreparationDetailDesktopBloc(
    this._addPreparationDetailUseCase,
    this._getPreparationDetailsUseCase,
  ) : super(PreparationDetailDesktopState()) {
    on<OnGetPreparationDetails>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationDetailDesktop.loading));

      final failureOrPreparationDetails = await _getPreparationDetailsUseCase(
        preparationId: event.preparationId,
      );

      return failureOrPreparationDetails.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationDetailDesktop.failure,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            status: StatusPreparationDetailDesktop.loaded,
            preparationDetails: response,
          ),
        ),
      );
    });

    on<OnAddPreparationDetailEvent>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationDetailDesktop.loading));

      final failureOrPreparationDetails = await _addPreparationDetailUseCase(
        params: event.params,
      );

      return failureOrPreparationDetails.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationDetailDesktop.failure,
            message: failure.message,
          ),
        ),
        (response) async {
          final failureOrPrepsDetail = await _getPreparationDetailsUseCase(
            preparationId: event.params.preparationId!,
          );

          return failureOrPrepsDetail.fold(
            (_) {},
            (preps) => emit(
              state.copyWith(
                status: StatusPreparationDetailDesktop.loaded,
                preparationDetails: preps,
                message: response,
              ),
            ),
          );
        },
      );
    });
  }
}
