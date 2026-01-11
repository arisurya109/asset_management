import 'package:asset_management/domain/entities/asset/asset_detail_response.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_detail_by_id_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_detail_desktop_event.dart';
part 'asset_detail_desktop_state.dart';

class AssetDetailDesktopBloc
    extends Bloc<AssetDetailDesktopEvent, AssetDetailDesktopState> {
  final FindAssetDetailByIdUseCase _findAssetDetailByIdUseCase;

  AssetDetailDesktopBloc(this._findAssetDetailByIdUseCase)
    : super(AssetDetailDesktopState()) {
    on<OnGetAssetDetailEvent>((event, emit) async {
      emit(state.copyWith(status: StatusAssetDetailDesktop.loading));

      final failureOrResponse = await _findAssetDetailByIdUseCase(event.params);

      return failureOrResponse.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetDetailDesktop.failure,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            status: StatusAssetDetailDesktop.loaded,
            response: response,
          ),
        ),
      );
    });
  }
}
