import 'package:asset_management/domain/usecases/master/find_location_type_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_location_datas_state.dart';

class AddLocationDatasCubit extends Cubit<AddLocationDatasState> {
  final FindLocationTypeUseCase _findLocationTypeUseCase;
  AddLocationDatasCubit(this._findLocationTypeUseCase)
    : super(AddLocationDatasState());

  Future<List<String>> findLocationTypeForDropDown() async {
    final failureOrLocationType = await _findLocationTypeUseCase();

    return failureOrLocationType.fold((_) => [], (type) => type);
  }
}
