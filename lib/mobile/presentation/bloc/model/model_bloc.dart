import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/usecases/master/create_asset_model_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_asset_model_by_query_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'model_event.dart';
part 'model_state.dart';

class ModelBloc extends Bloc<ModelEvent, ModelState> {
  final FindAssetModelByQueryUseCase _findQuery;
  final CreateAssetModelUseCase _create;

  ModelBloc(this._findQuery, this._create) : super(ModelState()) {
    on<OnCreateModel>((event, emit) async {
      emit(state.copyWith(status: StatusModel.loading));

      final failureOrModel = await _create(event.params);

      return failureOrModel.fold(
        (failure) => emit(
          state.copyWith(status: StatusModel.failure, message: failure.message),
        ),
        (model) => emit(state.copyWith(status: StatusModel.success)),
      );
    });

    on<OnFindModelByQuery>((event, emit) async {
      emit(state.copyWith(status: StatusModel.loading));

      final failureOrModels = await _findQuery(event.params);

      return failureOrModels.fold(
        (failure) => emit(
          state.copyWith(status: StatusModel.failure, message: failure.message),
        ),
        (models) =>
            emit(state.copyWith(status: StatusModel.success, models: models)),
      );
    });

    on<OnClearAll>((event, emit) async {
      emit(state.copyWith(status: StatusModel.initial, clearAll: true));
    });
  }
}
