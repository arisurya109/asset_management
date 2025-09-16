// ignore_for_file: depend_on_referenced_packages

import '../../../domain/entities/asset_preparation.dart';
import '../../../domain/usecases/usecases.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'asset_preparation_event.dart';
part 'asset_preparation_state.dart';

class AssetPreparationBloc
    extends Bloc<AssetPreparationEvent, AssetPreparationState> {
  final CreatePreparationUseCase _create;
  final FindAllPreparationsUseCase _find;
  final UpdateStatusPreparationUseCase _update;
  final ExportPreparationUseCase _export;
  AssetPreparationBloc(this._create, this._find, this._update, this._export)
    : super(AssetPreparationState()) {
    on<OnCreatePreparation>((event, emit) async {
      emit(state.copyWith(status: StatusPreparation.loading));

      final failureOrPreparation = await _create(event.params);

      return failureOrPreparation.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparation.failed,
            message: failure.message,
          ),
        ),
        (preparation) => emit(
          state.copyWith(
            status: StatusPreparation.created,
            message:
                'Successfully Created Preparation ${preparation.storeName}',
            preparations: state.preparations?..add(preparation),
          ),
        ),
      );
    });
    on<OnFindAllPreparation>((event, emit) async {
      emit(state.copyWith(status: StatusPreparation.loading));

      final failureOrPreparations = await _find();

      return failureOrPreparations.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparation.failed,
            message: failure.message,
          ),
        ),
        (preparations) => emit(
          state.copyWith(
            status: StatusPreparation.loaded,
            preparations: preparations,
            message: null,
          ),
        ),
      );
    });
    on<OnUpdateStatusPreparaion>((event, emit) async {
      emit(state.copyWith(status: StatusPreparation.loading));

      final failureOrPreparation = await _update(event.params);

      return failureOrPreparation.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparation.failed,
            message: failure.message,
          ),
        ),
        (preparation) => emit(
          state.copyWith(
            message: null,
            status: StatusPreparation.updated,
            preparations: state.preparations
              ?..removeWhere((element) => element.id == preparation.id)
              ..add(preparation)
              ..sort((a, b) => a.id!.compareTo(b.id!)),
          ),
        ),
      );
    });
    on<OnSelectedPreparation>((event, emit) {
      emit(state.copyWith(preparation: event.params));
    });
    on<OnExportPreparation>((event, emit) async {});
  }
}
