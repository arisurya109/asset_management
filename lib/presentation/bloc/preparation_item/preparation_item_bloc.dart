import 'package:asset_management/domain/entities/preparation/preparation_item.dart';
import 'package:asset_management/domain/usecases/preparation/create_preparation_item_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_item_by_preparation_detail_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_item_by_preparation_id_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'preparation_item_event.dart';
part 'preparation_item_state.dart';

class PreparationItemBloc
    extends Bloc<PreparationItemEvent, PreparationItemState> {
  final CreatePreparationItemUseCase _createPreparationItemUseCase;
  final FindAllPreparationItemByPreparationIdUseCase
  _findAllPreparationItemByPreparationIdUseCase;
  final FindAllPreparationItemByPreparationDetailIdUseCase
  _findAllPreparationItemByPreparationDetailIdUseCase;
  PreparationItemBloc(
    this._createPreparationItemUseCase,
    this._findAllPreparationItemByPreparationIdUseCase,
    this._findAllPreparationItemByPreparationDetailIdUseCase,
  ) : super(PreparationItemState()) {
    on<OnCreatePreparationItem>((event, emit) async {
      emit(state.copyWith(status: StatusPreparationItem.loading));

      await Future.delayed(Duration(seconds: 5));

      final failureOrItem = await _createPreparationItemUseCase(event.params);

      return failureOrItem.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparationItem.failed,
            message: failure.message,
          ),
        ),
        (item) => emit(
          state.copyWith(
            status: StatusPreparationItem.success,
            preparationItem: [...?state.preparationItem, item],
          ),
        ),
      );
    });

    on<OnFindAllPreparationItemsByPreparationId>((event, emit) async {
      final failureOrItems =
          await _findAllPreparationItemByPreparationIdUseCase(
            event.preparationId,
          );

      return failureOrItems.fold(
        (failure) => emit(state.copyWith(message: failure.message)),
        (items) => emit(state.copyWith(preparationItems: items)),
      );
    });

    on<OnFindAllPreparationItemsByPreparationDetailId>((event, emit) async {
      final failureOrItems =
          await _findAllPreparationItemByPreparationDetailIdUseCase(
            event.preparationDetailId,
            event.preparationId,
          );

      return failureOrItems.fold(
        (failure) => emit(state.copyWith(message: failure.message)),
        (items) => emit(state.copyWith(preparationItem: items)),
      );
    });
  }
}
