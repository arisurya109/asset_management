// ignore_for_file: depend_on_referenced_packages

import '../../../domain/usecases/usecases.dart';
import '../../../domain/entities/asset_preparation_detail.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_preparation_detail_event.dart';
part 'asset_preparation_detail_state.dart';

class AssetPreparationDetailBloc
    extends Bloc<AssetPreparationDetailEvent, AssetPreparationDetailState> {
  final InsertAssetPreparationDetailUseCase _insert;
  final FindAllAssetPreparationDetailUseCase _find;
  final DeleteAssetPreparationDetailUseCase _delete;

  AssetPreparationDetailBloc(this._insert, this._find, this._delete)
    : super(AssetPreparationDetailState()) {
    on<OnFindAllPreparationDetails>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationDetail.loading));

      final failureOrPreparationDetails = await _find(event.preparationId);

      return failureOrPreparationDetails.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationDetail.failed,
            message: failure.message,
          ),
        ),
        (preparations) => emit(
          state.copyWith(
            status: StatusPreparationDetail.loaded,
            preparations: preparations,
            message: null,
          ),
        ),
      );
    });
    on<OnInsertPreparationDetails>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationDetail.loading));

      final failureOrPreparation = await _insert(event.params);

      return failureOrPreparation.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationDetail.failed,
            message: failure.message,
          ),
        ),
        (preparation) => emit(
          state.copyWith(
            status: StatusPreparationDetail.created,
            message: 'Successfully add ${preparation.asset}',
            preparations: state.preparations?..add(preparation),
          ),
        ),
      );
    });
    on<OnDeletedPreparationDetails>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationDetail.loading));

      final failureOrDelete = await _delete(event.preparationId, event.params);

      return failureOrDelete.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationDetail.failed,
            message: failure.message,
          ),
        ),
        (message) => emit(
          state.copyWith(
            status: StatusPreparationDetail.delete,
            message: message,
            preparations: state.preparations
              ?..removeWhere((element) => element.asset == event.params),
          ),
        ),
      );
    });
  }
}
