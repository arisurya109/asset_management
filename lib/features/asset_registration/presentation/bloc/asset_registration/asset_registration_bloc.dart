import 'package:asset_management/features/asset_registration/domain/entities/asset_registration.dart';
import 'package:asset_management/features/asset_registration/domain/usecases/create_asset_registration_consumable_use_case.dart';
import 'package:asset_management/features/asset_registration/domain/usecases/create_asset_registration_use_case.dart';
import 'package:asset_management/features/asset_registration/domain/usecases/find_all_asset_registration_use_case.dart';
import 'package:asset_management/features/asset_registration/domain/usecases/migration_asset_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_registration_event.dart';
part 'asset_registration_state.dart';

class AssetRegistrationBloc
    extends Bloc<AssetRegistrationEvent, AssetRegistrationState> {
  final CreateAssetRegistrationUseCase _createAssetRegistrationUseCase;
  final CreateAssetRegistrationConsumable _createAssetRegistrationConsumable;
  final MigrationAssetUseCase _migrationAssetUseCase;
  final FindAllAssetRegistrationUseCase _findAllAssetRegistrationUseCase;

  AssetRegistrationBloc(
    this._createAssetRegistrationUseCase,
    this._createAssetRegistrationConsumable,
    this._migrationAssetUseCase,
    this._findAllAssetRegistrationUseCase,
  ) : super(AssetRegistrationState()) {
    on<OnCreateAsset>((event, emit) async {
      emit(state.copyWith(status: StatusAssetRegistration.loading));

      final response = await _createAssetRegistrationUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(
            status: StatusAssetRegistration.failed,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetRegistration.success,
            assetsConsumable: state.assetsConsumable?..add(r),
          ),
        ),
      );
    });
    on<OnCreateAssetConsumable>((event, emit) async {
      emit(state.copyWith(status: StatusAssetRegistration.loading));

      final response = await _createAssetRegistrationConsumable(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(
            status: StatusAssetRegistration.failed,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetRegistration.success,
            assetNonCunsumable: state.assetNonConsumable?..add(r),
          ),
        ),
      );
    });
    on<OnFindAllAssetRegistration>((event, emit) async {
      emit(state.copyWith(status: StatusAssetRegistration.loading));

      final response = await _findAllAssetRegistrationUseCase();

      return response.fold(
        (l) => emit(
          state.copyWith(
            status: StatusAssetRegistration.failed,
            message: l.message,
          ),
        ),
        (r) {
          print('Ini response : ${r.first.toString()}');
          print(
            'Asset Code : ${r.where((element) => element.uom == 1).toList()}',
          );
          print(
            'Consumable : ${r.where((element) => element.uom == 0).toList()}',
          );
          emit(
            state.copyWith(
              status: StatusAssetRegistration.success,
              assetNonCunsumable: r
                  .where((element) => element.uom == 1)
                  .toList(),
              assetsConsumable: r.where((element) => element.uom == 0).toList(),
            ),
          );
        },
      );
    });
    on<OnMigrationAsset>((event, emit) async {
      emit(state.copyWith(status: StatusAssetRegistration.loading));

      final response = await _migrationAssetUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(
            status: StatusAssetRegistration.failed,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusAssetRegistration.success,
            assetNonCunsumable: state.assetsConsumable?..add(r),
          ),
        ),
      );
    });
  }
}
