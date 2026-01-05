// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/usecases/master/find_asset_brand_by_query_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/domain/usecases/master/create_asset_brand_use_case.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  final CreateAssetBrandUseCase _createAssetBrandUseCase;
  final FindAssetBrandByQueryUseCase _findAssetBrandByQueryUseCase;

  BrandBloc(this._createAssetBrandUseCase, this._findAssetBrandByQueryUseCase)
    : super(BrandState()) {
    on<OnCreateAssetBrand>((event, emit) async {
      emit(state.copyWith(status: StatusBrand.loading));

      final failureOrBrand = await _createAssetBrandUseCase(event.params);

      return failureOrBrand.fold(
        (failure) => emit(
          state.copyWith(status: StatusBrand.failure, message: failure.message),
        ),
        (brand) => emit(state.copyWith(status: StatusBrand.success)),
      );
    });

    on<OnFindAssetBrandByQuery>((event, emit) async {
      emit(state.copyWith(status: StatusBrand.loading));

      final failureOrBrands = await _findAssetBrandByQueryUseCase(event.params);

      return failureOrBrands.fold(
        (failure) => emit(
          state.copyWith(status: StatusBrand.failure, message: failure.message),
        ),
        (brands) =>
            emit(state.copyWith(status: StatusBrand.success, brands: brands)),
      );
    });

    on<OnClearAll>((event, emit) {
      emit(state.copyWith(clearAll: true));
    });
  }
}
