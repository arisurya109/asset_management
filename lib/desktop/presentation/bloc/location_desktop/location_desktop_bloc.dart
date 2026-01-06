import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/usecases/master/create_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_location_by_query_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'location_desktop_event.dart';
part 'location_desktop_state.dart';

class LocationDesktopBloc
    extends Bloc<LocationDesktopEvent, LocationDesktopState> {
  final FindAllLocationUseCase _findAllLocationUseCase;
  final FindLocationByQueryUseCase _findLocationByQueryUseCase;
  final CreateLocationUseCase _createLocationUseCase;

  LocationDesktopBloc(
    this._findAllLocationUseCase,
    this._findLocationByQueryUseCase,
    this._createLocationUseCase,
  ) : super(LocationDesktopState()) {
    on<OnCreateLocationEvent>((event, emit) async {
      emit(state.copyWith(status: StatusLocationDesktop.loading));

      final failureOrLocations = await _createLocationUseCase(event.params);

      return failureOrLocations.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusLocationDesktop.failure,
            message: failure.message,
          ),
        ),
        (location) => emit(
          state.copyWith(
            status: StatusLocationDesktop.success,
            message: 'Successfully create location ${location.name}',
          ),
        ),
      );
    });

    on<OnFindAllLocation>((event, emit) async {
      emit(state.copyWith(status: StatusLocationDesktop.loading));

      final failureOrAssets = await _findAllLocationUseCase();

      return failureOrAssets.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusLocationDesktop.failure,
            message: failure.message,
          ),
        ),
        (locations) => emit(
          state.copyWith(
            status: StatusLocationDesktop.loaded,
            locations: locations,
          ),
        ),
      );
    });

    on<OnFindAllLocationByQuery>((event, emit) async {
      emit(state.copyWith(status: StatusLocationDesktop.loading));

      final failureOrAssets = await _findLocationByQueryUseCase(event.query);

      return failureOrAssets.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusLocationDesktop.failure,
            message: failure.message,
          ),
        ),
        (locations) => emit(
          state.copyWith(
            status: StatusLocationDesktop.loaded,
            locations: locations,
          ),
        ),
      );
    });
  }
}
