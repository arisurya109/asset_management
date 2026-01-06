import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/entities/master/location_pagination.dart';
import 'package:asset_management/domain/usecases/master/create_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_location_by_pagination_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'location_desktop_event.dart';
part 'location_desktop_state.dart';

class LocationDesktopBloc
    extends Bloc<LocationDesktopEvent, LocationDesktopState> {
  final CreateLocationUseCase _createLocationUseCase;
  final FindLocationByPaginationUseCase _findLocationByPaginationUseCase;

  LocationDesktopBloc(
    this._createLocationUseCase,
    this._findLocationByPaginationUseCase,
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

    on<OnFindLocationPagination>((event, emit) async {
      emit(state.copyWith(status: StatusLocationDesktop.loading));

      final failureOrAssets = await _findLocationByPaginationUseCase(
        limit: event.limit!,
        page: event.page!,
        query: event.query,
      );

      return failureOrAssets.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusLocationDesktop.failure,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            status: StatusLocationDesktop.loaded,
            response: response,
          ),
        ),
      );
    });
  }
}
