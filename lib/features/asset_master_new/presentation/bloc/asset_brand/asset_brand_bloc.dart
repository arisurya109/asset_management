import 'package:asset_management/features/asset_master_new/asset_master_export.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_brand_event.dart';
part 'asset_brand_state.dart';

class AssetBrandBloc extends Bloc<AssetBrandEvent, AssetBrandState> {
  final FindAllAssetBrandUseCase _findAllAssetBrandUseCase;
  final FindByIdAssetBrandUseCase _findByIdAssetBrandUseCase;
  final CreateAssetBrandUseCase _createAssetBrandUseCase;
  final UpdateAssetBrandUseCase _updateAssetBrandUseCase;

  AssetBrandBloc(
    this._findAllAssetBrandUseCase,
    this._findByIdAssetBrandUseCase,
    this._createAssetBrandUseCase,
    this._updateAssetBrandUseCase,
  ) : super(AssetBrandState()) {
    on<OnGetAllAssetBrand>((event, emit) async {
      emit(state.copyWith(status: StatusAssetBrand.loading));

      final response = await _findAllAssetBrandUseCase();

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetBrand.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(status: StatusAssetBrand.success, assetBrands: r),
        ),
      );
    });

    on<OnGetAssetBrandById>((event, emit) async {
      emit(state.copyWith(status: StatusAssetBrand.loading));

      final response = await _findByIdAssetBrandUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetBrand.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(status: StatusAssetBrand.success, assetBrand: r),
        ),
      );
    });

    on<OnCreateAssetBrand>((event, emit) async {
      emit(state.copyWith(status: StatusAssetBrand.loading));

      final response = await _createAssetBrandUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetBrand.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetBrand.success,
            assetBrands: state.assetBrands?..add(r),
          ),
        ),
      );
    });

    on<OnUpdateAssetBrand>((event, emit) async {
      emit(state.copyWith(status: StatusAssetBrand.loading));

      final response = await _updateAssetBrandUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusAssetBrand.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetBrand.success,
            assetBrands: state.assetBrands
              ?..removeWhere((element) => element.id == r.id)
              ..add(r),
          ),
        ),
      );
    });
  }
}
