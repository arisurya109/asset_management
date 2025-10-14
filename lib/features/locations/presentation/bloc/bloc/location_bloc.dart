// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/features/locations/domain/usecases/create_location_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:asset_management/features/locations/domain/entities/location.dart';
import 'package:asset_management/features/locations/domain/usecases/find_all_location_use_case.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final FindAllLocationUseCase _findAllLocation;
  final CreateLocationUseCase _createLocationUseCase;

  LocationBloc(this._findAllLocation, this._createLocationUseCase)
    : super(LocationState()) {
    on<OnCreateLocation>((event, emit) async {
      emit(state.copyWith(status: StatusLocation.loading));

      final response = await _createLocationUseCase(event.params);

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusLocation.failed, message: l.message),
        ),
        (r) => emit(
          state.copyWith(
            status: StatusLocation.success,
            locations: state.locations?..add(r),
          ),
        ),
      );
    });

    on<OnGetAllLocation>((event, emit) async {
      emit(state.copyWith(status: StatusLocation.loading));

      final response = await _findAllLocation();

      return response.fold(
        (l) => emit(
          state.copyWith(status: StatusLocation.failed, message: l.message),
        ),
        (r) =>
            emit(state.copyWith(status: StatusLocation.success, locations: r)),
      );
    });
  }
}
