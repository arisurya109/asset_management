import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/usecases/preparation/create_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_detail_by_preparation_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_detail_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/update_preparation_detail_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preparation_detail_event.dart';
part 'preparation_detail_state.dart';

class PreparationDetailBloc
    extends Bloc<PreparationDetailEvent, PreparationDetailState> {
  final CreatePreparationDetailUseCase _createPreparationDetailUseCase;
  final FindAllPreparationDetailByPreparationIdUseCase
  _findAllPreparationDetailByPreparationIdUseCase;
  final FindPreparationDetailByIdUseCase _findPreparationDetailByIdUseCase;
  final UpdatePreparationDetailUseCase _updatePreparationDetailUseCase;

  PreparationDetailBloc(
    this._createPreparationDetailUseCase,
    this._findAllPreparationDetailByPreparationIdUseCase,
    this._findPreparationDetailByIdUseCase,
    this._updatePreparationDetailUseCase,
  ) : super(PreparationDetailState()) {
    on<OnCreatePreparationDetail>(_createPreparationDetail);
    on<OnFindAllPreparationDetailByPreparationId>(_findAllPreparationDetail);
    on<OnFindPreparationDetailById>(_findPreparationDetail);
    on<OnUpdatePreparationDetail>(_updatePreparationDetail);
  }

  void _updatePreparationDetail(
    OnUpdatePreparationDetail event,
    Emitter<PreparationDetailState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparationDetail.loading));

    final failureOrPreparationDetail = await _updatePreparationDetailUseCase(
      event.params,
    );

    return failureOrPreparationDetail.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparationDetail.failed,
          message: failure.message,
        ),
      ),
      (preparationDetail) => emit(
        state.copyWith(
          status: StatusPreparationDetail.success,
          preparationDetails: state.preparationDetails
            ?..removeWhere((element) => element.id == preparationDetail.id)
            ..add(preparationDetail)
            ..sort((a, b) => a.id!.compareTo(b.id!)),
        ),
      ),
    );
  }

  void _findPreparationDetail(
    OnFindPreparationDetailById event,
    Emitter<PreparationDetailState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparationDetail.loading));

    final failureOrPreparationDetail = await _findPreparationDetailByIdUseCase(
      params: event.params,
      preparationId: event.preparationId,
    );

    return failureOrPreparationDetail.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparationDetail.failed,
          message: failure.message,
        ),
      ),
      (preparationDetail) => emit(
        state.copyWith(
          status: StatusPreparationDetail.success,
          preparationDetail: preparationDetail,
        ),
      ),
    );
  }

  void _findAllPreparationDetail(
    OnFindAllPreparationDetailByPreparationId event,
    Emitter<PreparationDetailState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparationDetail.loading));

    final failureOrPreparationDetails =
        await _findAllPreparationDetailByPreparationIdUseCase(event.params);

    await Future.delayed(Duration(seconds: 5));

    return failureOrPreparationDetails.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparationDetail.failed,
          message: failure.message,
        ),
      ),
      (preparationDetails) => emit(
        state.copyWith(
          status: StatusPreparationDetail.success,
          preparationDetails: preparationDetails,
        ),
      ),
    );
  }

  void _createPreparationDetail(
    OnCreatePreparationDetail event,
    Emitter<PreparationDetailState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparationDetail.loading));

    String? errorMessage;
    bool allDetailsSuccess = true;
    final List<PreparationDetail> createdDetails = [];

    for (var i = 0; i < event.params.length; i++) {
      final detail = event.params[i].copyWith(
        preparationId: event.preparationId,
      );

      final detailResult = await _createPreparationDetailUseCase(detail);

      detailResult.fold((failure) {
        allDetailsSuccess = false;
        errorMessage = failure.message;
      }, (result) => createdDetails.add(result));

      if (!allDetailsSuccess) break;
    }

    if (allDetailsSuccess) {
      emit(
        state.copyWith(
          status: StatusPreparationDetail.success,
          preparationDetails: createdDetails,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: StatusPreparationDetail.failed,
          message: errorMessage,
        ),
      );
    }
  }
}
