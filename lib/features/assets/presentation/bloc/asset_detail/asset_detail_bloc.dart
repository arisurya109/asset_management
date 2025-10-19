// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/assets/domain/usecases/find_asset_detail_by_id_use_case.dart';

part 'asset_detail_event.dart';
part 'asset_detail_state.dart';

class AssetDetailBloc extends Bloc<AssetDetailEvent, AssetDetailState> {
  final FindAssetDetailByIdUseCase _useCase;

  AssetDetailBloc(this._useCase) : super(AssetDetailState()) {
    on<OnGetAssetDetailById>((event, emit) async {
      emit(state.copyWith(status: StatusAssetDetail.loading));

      final failureOrAsset = await _useCase(event.params);

      return failureOrAsset.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetDetail.failed,
            message: failure.message,
          ),
        ),
        (assets) => emit(
          state.copyWith(
            status: StatusAssetDetail.success,
            assetDetail: assets,
          ),
        ),
      );
    });
  }
}
