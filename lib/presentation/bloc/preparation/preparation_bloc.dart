import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/usecases/preparation/create_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/create_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_detail_by_preparation_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_detail_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/update_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/update_preparation_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preparation_event.dart';
part 'preparation_state.dart';

class PreparationBloc extends Bloc<PreparationEvent, PreparationState> {
  final CreatePreparationUseCase _createPreparationUseCase;
  final FindAllPreparationUseCase _findAllPreparationUseCase;
  final FindPreparationByIdUseCase _findPreparationByIdUseCase;
  final UpdatePreparationUseCase _updatePreparationUseCase;

  final CreatePreparationDetailUseCase _createPreparationDetailUseCase;
  final FindAllPreparationDetailByPreparationIdUseCase
  _findAllPreparationDetailByPreparationIdUseCase;
  final FindPreparationDetailByIdUseCase _findPreparationDetailByIdUseCase;
  final UpdatePreparationDetailUseCase _updatePreparationDetailUseCase;

  PreparationBloc(
    this._createPreparationUseCase,
    this._findAllPreparationUseCase,
    this._findPreparationByIdUseCase,
    this._updatePreparationUseCase,
    this._createPreparationDetailUseCase,
    this._findAllPreparationDetailByPreparationIdUseCase,
    this._findPreparationDetailByIdUseCase,
    this._updatePreparationDetailUseCase,
  ) : super(PreparationState()) {
    on<OnCreatePreparationEvent>(_createPreparation);
    on<OnFindAllPreparationEvent>(_findAllPreparation);
    on<OnFindPreparationByIdEvent>(_findPreparationById);
    on<OnUpdatePreparationEvent>(_updatePreparation);
    on<OnCreatePreparationDetailEvent>(_createPreparationDetail);
    on<OnFindAllPrepartionDetailByPreparationId>(
      _findAllPreparationDetailByPreparationId,
    );
    on<OnFindPreparationDetailByIdEvent>(_findPreparationDetailById);
    on<OnUpdatePreparationDetailEvent>(_updatePreparationDetail);
  }

  void _createPreparationDetail(
    OnCreatePreparationDetailEvent event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparation.loading));

    final failureOrPreparationDetail = await _createPreparationDetailUseCase(
      event.params,
    );

    return failureOrPreparationDetail.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparation.failed,
          message: failure.message,
        ),
      ),
      (preparationDetail) => emit(
        state.copyWith(
          status: StatusPreparation.success,
          preparationDetails: [...?state.preparationDetails, preparationDetail],
        ),
      ),
    );
  }

  void _createPreparation(
    OnCreatePreparationEvent event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparation.loading));

    final failureOrPreparation = await _createPreparationUseCase(event.params);

    return failureOrPreparation.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparation.failed,
          message: failure.message,
        ),
      ),
      (preparation) => emit(
        state.copyWith(
          status: StatusPreparation.success,
          preparations: [...?state.preparations, preparation],
        ),
      ),
    );
  }

  void _findAllPreparation(
    OnFindAllPreparationEvent event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparation.loading));

    final failureOrPreparation = await _findAllPreparationUseCase();

    return failureOrPreparation.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparation.failed,
          message: failure.message,
        ),
      ),
      (preparations) => emit(
        state.copyWith(
          status: StatusPreparation.success,
          preparations: preparations,
        ),
      ),
    );
  }

  void _findAllPreparationDetailByPreparationId(
    OnFindAllPrepartionDetailByPreparationId event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparation.loading));

    final failureOrPreparationDetails =
        await _findAllPreparationDetailByPreparationIdUseCase(event.params);

    return failureOrPreparationDetails.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparation.failed,
          message: failure.message,
        ),
      ),
      (preparationDetails) => emit(
        state.copyWith(
          status: StatusPreparation.success,
          preparationDetails: preparationDetails,
        ),
      ),
    );
  }

  void _findPreparationById(
    OnFindPreparationByIdEvent event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparation.loading));

    final failureOrPreparation = await _findPreparationByIdUseCase(
      event.params,
    );

    return failureOrPreparation.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparation.failed,
          message: failure.message,
        ),
      ),
      (preparation) => emit(
        state.copyWith(
          status: StatusPreparation.success,
          preparation: preparation,
        ),
      ),
    );
  }

  void _findPreparationDetailById(
    OnFindPreparationDetailByIdEvent event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparation.loading));

    final failureOrPreparationDetail = await _findPreparationDetailByIdUseCase(
      params: event.params,
      preparationId: event.preparationId,
    );

    return failureOrPreparationDetail.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparation.failed,
          message: failure.message,
        ),
      ),
      (preparationDetail) => emit(
        state.copyWith(
          status: StatusPreparation.success,
          preparationDetail: preparationDetail,
        ),
      ),
    );
  }

  void _updatePreparation(
    OnUpdatePreparationEvent event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparation.loading));

    final failureOrPreparation = await _updatePreparationUseCase(event.params);

    return failureOrPreparation.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparation.failed,
          message: failure.message,
        ),
      ),
      (preparation) => emit(
        state.copyWith(
          status: StatusPreparation.success,
          preparations: state.preparations
            ?..removeWhere((element) => element.id == event.params.id)
            ..add(preparation)
            ..sort((a, b) => a.id!.compareTo(b.id!)),
        ),
      ),
    );
  }

  void _updatePreparationDetail(
    OnUpdatePreparationDetailEvent event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparation.loading));

    final failureOrPreparationDetail = await _updatePreparationDetailUseCase(
      event.params,
    );

    return failureOrPreparationDetail.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparation.failed,
          message: failure.message,
        ),
      ),
      (preparationDetail) => emit(
        state.copyWith(
          status: StatusPreparation.success,
          preparationDetails: state.preparationDetails
            ?..removeWhere((element) => element.id == event.params.id)
            ..add(preparationDetail)
            ..sort((a, b) => a.id!.compareTo(b.id!)),
        ),
      ),
    );
  }
}
