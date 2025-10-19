import 'package:asset_management/features/asset_type/domain/entities/asset_type.dart';
import 'package:asset_management/features/asset_type/domain/usecases/create_asset_type_use_case.dart';
import 'package:asset_management/features/asset_type/domain/usecases/find_all_asset_type_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_type_event.dart';
part 'asset_type_state.dart';

class AssetTypeBloc extends Bloc<AssetTypeEvent, AssetTypeState> {
  final FindAllAssetTypeUseCase _findAllAssetTypeUseCase;
  final CreateAssetTypeUseCase _createAssetTypeUseCase;

  AssetTypeBloc(this._findAllAssetTypeUseCase, this._createAssetTypeUseCase)
    : super(AssetTypeState()) {
    on<OnCreateAssetType>((event, emit) async {
      emit(state.copyWith(status: StatusAssetType.loading));

      final failureOrTypes = await _createAssetTypeUseCase(event.params);

      return failureOrTypes.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetType.failed,
            message: failure.message,
          ),
        ),
        (types) => emit(
          state.copyWith(
            status: StatusAssetType.success,
            types: state.types?..add(types),
          ),
        ),
      );
    });

    on<OnGetAllAssetType>((event, emit) async {
      emit(state.copyWith(status: StatusAssetType.loading));

      final failureOrTypes = await _findAllAssetTypeUseCase();

      return failureOrTypes.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetType.failed,
            message: failure.message,
          ),
        ),
        (types) =>
            emit(state.copyWith(status: StatusAssetType.success, types: types)),
      );
    });
  }
}
