import 'package:asset_management/features/location/domain/entities/location.dart';
import 'package:asset_management/features/location/domain/usecases/create_location_use_case.dart';
import 'package:asset_management/features/location/domain/usecases/find_all_location_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final FindAllLocationUseCase _findAllLocationUseCase;
  final CreateLocationUseCase _createLocationUseCase;

  LocationBloc(this._findAllLocationUseCase, this._createLocationUseCase)
    : super(LocationState()) {
    on<OnGetAllLocation>((event, emit) async {
      emit(state.copyWith(status: StatusLocation.loading));

      final failureOrLocation = await _findAllLocationUseCase();

      return failureOrLocation.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusLocation.failed,
            message: failure.message,
          ),
        ),
        (location) => emit(
          state.copyWith(status: StatusLocation.success, locations: location),
        ),
      );
    });

    on<OnCreateLocation>((event, emit) async {
      emit(state.copyWith(status: StatusLocation.loading));

      final failureOrLocation = await _createLocationUseCase(event.params);

      return failureOrLocation.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusLocation.failed,
            message: failure.message,
          ),
        ),
        (location) => emit(
          state.copyWith(
            status: StatusLocation.success,
            locations: state.locations?..add(location),
          ),
        ),
      );
    });
  }
}
