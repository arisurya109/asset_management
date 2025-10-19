import 'package:asset_management/features/registration/domain/entities/registration.dart';
import 'package:asset_management/features/registration/domain/usecases/registration_asset_consumable_use_case.dart';
import 'package:asset_management/features/registration/domain/usecases/registration_asset_non_consumable_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationAssetConsumableUseCase _consumableUseCase;
  final RegistrationAssetNonConsumableUseCase _nonConsumableUseCase;
  RegistrationBloc(this._consumableUseCase, this._nonConsumableUseCase)
    : super(RegistrationState()) {
    on<OnRegistrationAssetConsumable>((event, emit) async {
      emit(state.copyWith(status: StatusRegistration.loading));

      final failureOrResponse = await _consumableUseCase(event.params);

      return failureOrResponse.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusRegistration.failed,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            status: StatusRegistration.success,
            response: response,
          ),
        ),
      );
    });
    on<OnRegistrationAssetNonConsumable>((event, emit) async {
      emit(state.copyWith(status: StatusRegistration.loading));

      final failureOrResponse = await _nonConsumableUseCase(event.params);

      return failureOrResponse.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusRegistration.failed,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            status: StatusRegistration.success,
            response: response,
          ),
        ),
      );
    });
  }
}
