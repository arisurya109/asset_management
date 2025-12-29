import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/usecases/asset/create_asset_transfer_use_case.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_query_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_location_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preparation_update_state.dart';

class PreparationUpdateCubit extends Cubit<PreparationUpdateState> {
  final FindAssetByQueryUseCase _findAssetByQueryUseCase;
  final FindAllLocationUseCase _findAllLocationUseCase;
  final CreateAssetTransferUseCase _createAssetTransferUseCase;

  PreparationUpdateCubit(
    this._findAssetByQueryUseCase,
    this._findAllLocationUseCase,
    this._createAssetTransferUseCase,
  ) : super(PreparationUpdateState());

  void updatePreparationAsset({
    required int asetId,
    required String movementType,
    required int fromL,
    required int toL,
    required int qty,
  }) async {
    emit(state.copyWith(status: StatusPreparationUpdate.loading));

    final failureOrAsset = await _createAssetTransferUseCase(
      assetId: asetId,
      fromLocationId: fromL,
      toLocationId: toL,
      movementType: movementType,
      quantity: qty,
    );

    return failureOrAsset.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPreparationUpdate.failure,
          message: failure.message,
        ),
      ),
      (asset) => emit(
        state.copyWith(
          status: StatusPreparationUpdate.success,
          message:
              'Successfully update ${asset.assetCode} To ${asset.locationDetail}',
        ),
      ),
    );
  }

  Future<AssetEntity?> findAsset(String params) async {
    final failureOrAsset = await _findAssetByQueryUseCase(params: params);

    return failureOrAsset.fold(
      (failure) {
        emit(state.copyWith(message: failure.message));
        return;
      },
      (assets) async {
        final failureOrLocations = await _findAllLocationUseCase();

        return failureOrLocations.fold(
          (failure) {
            return null;
          },
          (locations) {
            final asset = assets
                .where((element) => element.assetCode == params)
                .firstOrNull;

            if (asset == null) {
              return null;
            }

            final locationId = locations.firstWhere(
              (element) => element.name == asset.locationDetail,
            );

            asset.locationId = locationId.id;

            return asset;
          },
        );
      },
    );
  }

  Future<List<Location>> getLocationsForDropdown() async {
    final failureOrLocations = await _findAllLocationUseCase();

    return failureOrLocations.fold(
      (_) {
        return [];
      },
      (locations) {
        final locationsNonStorage = locations
            .where((element) => element.isStorage == 0)
            .toList();
        return locationsNonStorage;
      },
    );
  }
}
