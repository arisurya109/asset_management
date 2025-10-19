// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:asset_management/features/asset_category/domain/entities/asset_category.dart';
import 'package:asset_management/features/asset_category/domain/usecases/create_asset_category_use_case.dart';
import 'package:asset_management/features/asset_category/domain/usecases/find_all_asset_category_use_case.dart';

part 'asset_category_event.dart';
part 'asset_category_state.dart';

class AssetCategoryBloc extends Bloc<AssetCategoryEvent, AssetCategoryState> {
  final FindAllAssetCategoryUseCase _findAllcategoryUseCase;
  final CreateAssetCategoryUseCase _createAssetCategoryUseCase;

  AssetCategoryBloc(
    this._findAllcategoryUseCase,
    this._createAssetCategoryUseCase,
  ) : super(AssetCategoryState()) {
    on<OnCreateAssetCategory>((event, emit) async {
      emit(state.copyWith(status: StatusAssetCategory.loading));

      final failureOrCategory = await _createAssetCategoryUseCase(event.params);

      return failureOrCategory.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetCategory.failed,
            message: failure.message,
          ),
        ),
        (category) => emit(
          state.copyWith(
            status: StatusAssetCategory.success,
            category: state.category?..add(category),
          ),
        ),
      );
    });

    on<OnGetAllAssetCategory>((event, emit) async {
      emit(state.copyWith(status: StatusAssetCategory.loading));

      final failureOrCategory = await _findAllcategoryUseCase();

      return failureOrCategory.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetCategory.failed,
            message: failure.message,
          ),
        ),
        (category) => emit(
          state.copyWith(
            status: StatusAssetCategory.success,
            category: category,
          ),
        ),
      );
    });
  }
}
