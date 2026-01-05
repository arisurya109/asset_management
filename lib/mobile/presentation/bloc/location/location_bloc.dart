import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/usecases/master/create_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_location_by_query_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final FindLocationByQueryUseCase _findByQuery;
  final CreateLocationUseCase _create;
  LocationBloc(this._findByQuery, this._create) : super(LocationState()) {
    on<OnFindLocationByQuery>((event, emit) async {
      emit(state.copyWith(status: StatusLocation.loading));

      final failureOrLocations = await _findByQuery(event.params);

      return failureOrLocations.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusLocation.failure,
            message: failure.message,
          ),
        ),
        (locations) => emit(
          state.copyWith(status: StatusLocation.success, locations: locations),
        ),
      );
    });

    on<OnCreateLocationEvent>((event, emit) async {
      emit(state.copyWith(status: StatusLocation.loading));

      final failureOrLocations = await _create(event.params);

      return failureOrLocations.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusLocation.failure,
            message: failure.message,
          ),
        ),
        (location) => emit(
          state.copyWith(
            status: StatusLocation.success,
            message: 'Successfully create location ${location.name}',
          ),
        ),
      );
    });

    on<OnClearAll>((event, emit) async {
      emit(state.copyWith(status: StatusLocation.initial, clearAll: true));
    });
  }
}
