import 'package:asset_management/features/asset_master_new/asset_master_export.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_model_event.dart';
part 'asset_model_state.dart';

class AssetModelBloc extends Bloc<AssetModelEvent, AssetModelState> {
  final FindAllAssetModelUseCase _findAllAssetModelUseCase;
  final FindByIdAssetModelUseCase _findByIdAssetModelUseCase;
  final CreateAssetModelUseCase _createAssetModelUseCase;
  final UpdateAssetModelUseCase _updateAssetModelUseCase;

  AssetModelBloc(
    this._findAllAssetModelUseCase,
    this._findByIdAssetModelUseCase,
    this._createAssetModelUseCase,
    this._updateAssetModelUseCase,
  ) : super(AssetModelState()) {
    on<OnGetAllAssetModel>((event, emit) async {
      emit(state.copyWith(status: StatusAssetModel.loading));

      final response = await _findAllAssetModelUseCase();

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetModel.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(status: StatusAssetModel.success, assetModels: r),
        ),
      );
    });

    on<OnGetAssetModelById>((event, emit) async {
      emit(state.copyWith(status: StatusAssetModel.loading));

      final response = await _findByIdAssetModelUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetModel.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(status: StatusAssetModel.success, assetModel: r),
        ),
      );
    });

    on<OnCreateAssetModel>((event, emit) async {
      emit(state.copyWith(status: StatusAssetModel.loading));

      final response = await _createAssetModelUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetModel.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetModel.success,
            assetModels: state.assetModels?..add(r),
          ),
        ),
      );
    });

    on<OnUpdateAssetModel>((event, emit) async {
      emit(state.copyWith(status: StatusAssetModel.loading));

      final response = await _updateAssetModelUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetModel.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetModel.success,
            assetModels: state.assetModels
              ?..removeWhere((element) => element.id == r.id)
              ..add(r),
          ),
        ),
      );
    });
  }
}
