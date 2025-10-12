import 'package:asset_management/features/asset_master_new/asset_master_export.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_category_event.dart';
part 'asset_category_state.dart';

class AssetCategoryBloc extends Bloc<AssetCategoryEvent, AssetCategoryState> {
  final FindAllAssetCategoryUseCase _findAllAssetCategoryUseCase;
  final FindByIdAssetCategoryUseCase _findByIdAssetCategoryUseCase;
  final CreateAssetCategoryUseCase _createAssetCategoryUseCase;
  final UpdateAssetCategoryUseCase _updateAssetCategoryUseCase;

  AssetCategoryBloc(
    this._findAllAssetCategoryUseCase,
    this._findByIdAssetCategoryUseCase,
    this._createAssetCategoryUseCase,
    this._updateAssetCategoryUseCase,
  ) : super(AssetCategoryState()) {
    on<OnGetAllAssetCategory>((event, emit) async {
      emit(state.copyWith(status: StatusAssetCategory.loading));

      final response = await _findAllAssetCategoryUseCase();

      return response.fold(
        (l) => emit(
          state.copyWith(
            status: StatusAssetCategory.failed,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetCategory.success,
            assetCategories: r,
          ),
        ),
      );
    });
    on<OnGetAssetCategoryById>((event, emit) async {
      emit(state.copyWith(status: StatusAssetCategory.loading));

      final response = await _findByIdAssetCategoryUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(
            status: StatusAssetCategory.failed,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(status: StatusAssetCategory.success, assetCategory: r),
        ),
      );
    });

    on<OnCreateAssetCategory>((event, emit) async {
      emit(state.copyWith(status: StatusAssetCategory.loading));

      final response = await _createAssetCategoryUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(
            status: StatusAssetCategory.failed,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetCategory.success,
            assetCategories: state.assetCategories?..add(r),
          ),
        ),
      );
    });

    on<OnUpdateAssetCategory>((event, emit) async {
      emit(state.copyWith(status: StatusAssetCategory.loading));

      final response = await _updateAssetCategoryUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(
            status: StatusAssetCategory.failed,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetCategory.success,
            assetCategories: state.assetCategories
              ?..removeWhere((element) => element.id == r.id)
              ..add(r),
          ),
        ),
      );
    });
  }
}
