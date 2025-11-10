import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/usecases/preparation/create_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/update_preparation_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preparation_event.dart';
part 'preparation_state.dart';

class PreparationBloc extends Bloc<PreparationEvent, PreparationState> {
  final CreatePreparationUseCase _createPreparationUseCase;
  final FindAllPreparationUseCase _findAllPreparationUseCase;
  final UpdatePreparationUseCase _updatePreparationUseCase;
  final FindPreparationByIdUseCase _findPreparatioByIdUseCase;

  PreparationBloc(
    this._createPreparationUseCase,
    this._findAllPreparationUseCase,
    this._updatePreparationUseCase,
    this._findPreparatioByIdUseCase,
  ) : super(PreparationState()) {
    on<OnCreatePreparationEvent>(_createPreparation);
    on<OnFindAllPreparationEvent>(_findAllPreparation);
    on<OnUpdatePreparationEvent>(_updatePreparation);
    on<OnFindPreparationByIdEvent>(_findPreparationById);
  }

  void _findPreparationById(
    OnFindPreparationByIdEvent event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparation.loading));

    final failureOrPreparation = await _findPreparatioByIdUseCase(event.params);

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
            ?..removeWhere((element) => element.id == preparation.id)
            ..add(preparation)
            ..sort((a, b) => a.id!.compareTo(b.id!)),
        ),
      ),
    );
  }

  void _findAllPreparation(
    OnFindAllPreparationEvent event,
    Emitter<PreparationState> emit,
  ) async {
    emit(state.copyWith(status: StatusPreparation.loading));

    final failureOrPreparations = await _findAllPreparationUseCase();

    return failureOrPreparations.fold(
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
          preparation: preparation,
        ),
      ),
    );
  }
}
