import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../asset_master_export.dart';

part 'asset_type_event.dart';
part 'asset_type_state.dart';

class AssetTypeBloc extends Bloc<AssetTypeEvent, AssetTypeState> {
  final FindAllAssetTypeUseCase _findAllAssetTypeUseCase;
  final CreateAssetTypeUseCase _createAssetTypeUseCase;
  final UpdateAssetTypeUseCase _updateAssetTypeUseCase;
  final FindByIdAssetTypeUseCase _findByIdAssetTypeUseCase;

  AssetTypeBloc(
    this._findAllAssetTypeUseCase,
    this._createAssetTypeUseCase,
    this._updateAssetTypeUseCase,
    this._findByIdAssetTypeUseCase,
  ) : super(AssetTypeState()) {
    on<OnCreateAssetType>((event, emit) async {
      emit(state.copyWith(status: StatusAssetType.loading));

      final response = await _createAssetTypeUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetType.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetType.success,
            assetTypes: state.assetTypes?..add(r),
          ),
        ),
      );
    });

    on<OnGetAllAssetType>((event, emit) async {
      emit(state.copyWith(status: StatusAssetType.loading));

      final response = await _findAllAssetTypeUseCase();

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetType.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(status: StatusAssetType.success, assetTypes: r),
        ),
      );
    });

    on<OnGetAssetTypeById>((event, emit) async {
      emit(state.copyWith(status: StatusAssetType.loading));

      final response = await _findByIdAssetTypeUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetType.failed, message: l.message),
        ),
        (r) =>
            emit(state.copyWith(status: StatusAssetType.success, assetType: r)),
      );
    });

    on<OnUpdateAssetType>((event, emit) async {
      emit(state.copyWith(status: StatusAssetType.loading));

      final response = await _updateAssetTypeUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetType.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetType.success,
            assetTypes: state.assetTypes
              ?..removeWhere((element) => element.id == r.id)
              ..add(r),
          ),
        ),
      );
    });
  }
}
