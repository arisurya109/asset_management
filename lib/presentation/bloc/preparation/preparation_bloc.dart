// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asset_management/domain/usecases/preparation/create_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/update_status_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_detail/find_all_preparation_by_preparation_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_item/find_all_preparation_item_by_preparation_detail_id_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:asset_management/domain/entities/preparation_item/preparation_item.dart';
import 'package:asset_management/domain/usecases/preparation_detail/create_preparation_detail_use_case.dart';

part 'preparation_event.dart';
part 'preparation_state.dart';

class PreparationBloc extends Bloc<PreparationEvent, PreparationState> {
  final CreatePreparationUseCase _createPreparationUseCase;
  final CreatePreparationDetailUseCase _createPreparationDetailUseCase;
  final FindAllPreparationUseCase _findAllPreparationUseCase;

  final FindPreparationByIdUseCase _findPreparationByIdUseCase;
  final FindAllPreparationDetailByPreparationIdUseCase
  _findAllPreparationDetailByPreparationIdUseCase;

  final UpdateStatusPreparationUseCase _updateStatusPreparationUseCase;

  final FindAllPreparationItemByPreparationDetailIdUseCase
  _findAllPreparationItemByPreparationDetailIdUseCase;

  PreparationBloc(
    this._createPreparationUseCase,
    this._createPreparationDetailUseCase,
    this._findAllPreparationUseCase,
    this._findAllPreparationDetailByPreparationIdUseCase,
    this._findPreparationByIdUseCase,
    this._updateStatusPreparationUseCase,
    this._findAllPreparationItemByPreparationDetailIdUseCase,
  ) : super(PreparationState()) {
    on<OnCreatePreparation>((event, emit) async {
      emit(state.copyWith(status: StatusPreparation.loading));

      final failureOrPreparation = await _createPreparationUseCase(
        params: event.preparation,
      );

      return failureOrPreparation.fold(
        (failure) => emit(state.copyWith(status: StatusPreparation.failure)),
        (preparation) async {
          String? errorMessage;
          bool allDetailsSuccess = true;
          final List<PreparationDetail> createdDetails = [];

          for (var i = 0; i < event.preparationDetail.length; i++) {
            final detail = event.preparationDetail[i].copyWith(
              preparationId: preparation.id,
            );

            final detailResult = await _createPreparationDetailUseCase(
              params: detail,
            );

            detailResult.fold((failure) {
              allDetailsSuccess = false;
              errorMessage = failure.message;
            }, (result) => createdDetails.add(result));

            if (!allDetailsSuccess) break;
          }
          if (allDetailsSuccess) {
            emit(
              state.copyWith(
                status: StatusPreparation.createPreparation,
                message: 'Successfully create new preparation',
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: StatusPreparation.failure,
                message: errorMessage,
              ),
            );
          }
        },
      );
    });
    on<OnFindAllPreparation>((event, emit) async {
      emit(state.copyWith(status: StatusPreparation.loading));

      final failureOrPreparations = await _findAllPreparationUseCase();

      return failureOrPreparations.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparation.failure,
            message: failure.message,
          ),
        ),
        (preparations) => emit(
          state.copyWith(
            status: StatusPreparation.loaded,
            preparations: preparations,
          ),
        ),
      );
    });
    on<OnFindPreparationById>((event, emit) async {
      emit(state.copyWith(status: StatusPreparation.loading));

      final failureOrPreparation = await _findPreparationByIdUseCase(
        id: event.id,
      );

      return failureOrPreparation.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparation.failure,
            message: failure.message,
          ),
        ),
        (preparation) async {
          final failureOrPreparationDetails =
              await _findAllPreparationDetailByPreparationIdUseCase(
                id: event.id,
              );

          return failureOrPreparationDetails.fold(
            (failure) => emit(
              state.copyWith(
                status: StatusPreparation.failure,
                message: failure.message,
              ),
            ),
            (preparationDetails) => emit(
              state.copyWith(
                status: StatusPreparation.loaded,
                preparation: preparation,
                preparationDetails: preparationDetails,
              ),
            ),
          );
        },
      );
    });
    on<OnUpdateStatusPreparation>((event, emit) async {
      emit(state.copyWith(status: StatusPreparation.loading));

      final failureOrPreparation = await _updateStatusPreparationUseCase(
        id: event.id,
        params: event.params,
      );

      return failureOrPreparation.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparation.failure,
            message: failure.message,
          ),
        ),
        (preparation) {
          var newStatus;

          switch (event.params) {
            case 'ASSIGNED':
              newStatus = 'Assigned';
            case 'PICKING':
              newStatus = 'Picking';
            case 'READY':
              newStatus = 'Ready';
            case 'APPROVED':
              newStatus = 'Approved';
            case 'COMPLETED':
              newStatus = 'Completed';
            case 'CANCELLED':
              newStatus = 'Cancelled';
            default:
              newStatus;
          }
          emit(
            state.copyWith(
              message: 'Successfully $newStatus Preparation',
              status: StatusPreparation.updatePreparation,
              preparations: state.preparations
                ?..removeWhere((element) => element.id == preparation.id)
                ..add(preparation)
                ..sort((a, b) => a.id!.compareTo(b.id!)),
            ),
          );
        },
      );
    });
    on<OnFindItemByPreparationDetail>((event, emit) async {
      emit(state.copyWith(status: StatusPreparation.loading));

      final failureOrItemsByDetail =
          await _findAllPreparationItemByPreparationDetailIdUseCase(
            id: event.preparationDetailId,
          );

      return failureOrItemsByDetail.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPreparation.failure,
            message: failure.message,
          ),
        ),
        (item) => emit(
          state.copyWith(
            status: StatusPreparation.findItemByPreparationDetailId,
            itemByPreparationDetail: item,
            preparationDetail: state.preparationDetails
                ?.where((element) => element.id == event.preparationDetailId)
                .first,
          ),
        ),
      );
    });
  }
}
