// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:asset_management/features/asset_brand/domain/entities/asset_brand.dart';
import 'package:asset_management/features/asset_brand/domain/usecases/create_asset_brand_use_case.dart';
import 'package:asset_management/features/asset_brand/domain/usecases/find_all_asset_brand_use_case.dart';

part 'asset_brand_event.dart';
part 'asset_brand_state.dart';

class AssetBrandBloc extends Bloc<AssetBrandEvent, AssetBrandState> {
  final FindAllAssetBrandUseCase _findAllAssetBrandUseCase;
  final CreateAssetBrandUseCase _createAssetBrandUseCase;

  AssetBrandBloc(this._findAllAssetBrandUseCase, this._createAssetBrandUseCase)
    : super(AssetBrandState()) {
    on<OnGetAllAssetBrand>((event, emit) async {
      emit(state.copyWith(status: StatusAssetBrand.loading));

      final failureOrBrands = await _findAllAssetBrandUseCase();

      return failureOrBrands.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetBrand.loading,
            message: failure.message,
          ),
        ),
        (brands) => emit(
          state.copyWith(status: StatusAssetBrand.success, brands: brands),
        ),
      );
    });

    on<OnCreateAssetBrand>((event, emit) async {
      emit(state.copyWith(status: StatusAssetBrand.loading));

      final failureOrBrands = await _createAssetBrandUseCase(event.params);

      return failureOrBrands.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetBrand.loading,
            message: failure.message,
          ),
        ),
        (brands) => emit(
          state.copyWith(
            status: StatusAssetBrand.success,
            brands: state.brands?..add(brands),
          ),
        ),
      );
    });
  }
}
