import 'package:asset_management/domain/entities/asset/asset_entity_pagination.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_pagination_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_desktop_event.dart';
part 'asset_desktop_state.dart';

class AssetDesktopBloc extends Bloc<AssetDesktopEvent, AssetDesktopState> {
  final FindAssetByPaginationUseCase _findAssetPagination;

  AssetDesktopBloc(this._findAssetPagination) : super(AssetDesktopState()) {
    on<OnFindAssetPagination>((event, emit) async {
      emit(state.copyWith(status: StatusAssetDesktop.loading));

      final failureOrAssets = await _findAssetPagination(
        limit: event.limit!,
        page: event.page!,
        query: event.query,
      );

      return failureOrAssets.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAssetDesktop.failure,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(status: StatusAssetDesktop.loaded, response: response),
        ),
      );
    });
  }
}
