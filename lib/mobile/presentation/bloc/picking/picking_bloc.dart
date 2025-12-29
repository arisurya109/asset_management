import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:asset_management/domain/entities/preparation_item/preparation_item.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_asset_code_and_location_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/update_status_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_detail/find_all_preparation_by_preparation_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_detail/find_preparation_detail_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_detail/update_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_detail/update_status_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_item/create_preparation_item_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_item/delete_preparation_item_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_item/find_all_preparation_item_by_preparation_detail_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_item/find_all_preparation_item_by_preparation_id_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'picking_event.dart';
part 'picking_state.dart';

class PickingBloc extends Bloc<PickingEvent, PickingState> {
  final FindAllPreparationUseCase _findAllPreparationUseCase;
  final UpdateStatusPreparationUseCase _updateStatusPreparationUseCase;

  final FindPreparationByIdUseCase _findPreparationByIdUseCase;
  final FindAllPreparationDetailByPreparationIdUseCase
  _findAllPreparationDetailByPreparationIdUseCase;
  final FindAllPreparationItemByPreparationIdUseCase
  _findAllPreparationItemByPreparationIdUseCase;
  final DeletePreparationItemUseCase _deletePreparationItemUseCase;

  final FindPreparationDetailByIdUseCase _findPreparationDetailByIdUseCase;
  final FindAllPreparationItemByPreparationDetailIdUseCase
  _findAllPreparationItemByPreparationDetailIdUseCase;
  final UpdatePreparationDetailUseCase _updatePreparationDetailUseCase;
  final UpdateStatusPreparationDetailUseCase
  _updateStatusPreparationDetailUseCase;

  final CreatePreparationItemUseCase _createPreparationItemUseCase;

  final FindAssetByAssetCodeAndLocationUseCase
  _findAssetByAssetCodeAndLocationUseCase;

  PickingBloc(
    this._findAllPreparationUseCase,
    this._findPreparationByIdUseCase,
    this._findAllPreparationDetailByPreparationIdUseCase,
    this._findAllPreparationItemByPreparationIdUseCase,
    this._findAllPreparationItemByPreparationDetailIdUseCase,
    this._findPreparationDetailByIdUseCase,
    this._createPreparationItemUseCase,
    this._findAssetByAssetCodeAndLocationUseCase,
    this._deletePreparationItemUseCase,
    this._updateStatusPreparationDetailUseCase,
    this._updatePreparationDetailUseCase,
    this._updateStatusPreparationUseCase,
  ) : super(PickingState()) {
    // on<OnFindAllPickingTask>((event, emit) async {
    //   emit(state.copyWith(status: StatusPicking.loading));

    //   await Future.delayed(Duration(seconds: 3));

    //   final failureOrPreparation = await _findAllPreparationUseCase();

    //   return failureOrPreparation.fold(
    //     (failure) => emit(
    //       state.copyWith(
    //         status: StatusPicking.failure,
    //         message: failure.message,
    //       ),
    //     ),
    //     (preparation) {
    //       final newPreparation = preparation.where((element) {
    //         return element.assignedId == event.userId &&
    //             (element.status == 'ASSIGNED' || element.status == 'PICKING');
    //       }).toList();

    //       emit(
    //         state.copyWith(
    //           status: StatusPicking.loaded,
    //           preparations: newPreparation,
    //         ),
    //       );
    //     },
    //   );
    // });

    on<OnFindPickingTaskDetail>((event, emit) async {
      emit(state.copyWith(status: StatusPicking.loading));

      await Future.delayed(Duration(seconds: 3));

      final failureOrPreparation = await _findPreparationByIdUseCase(
        id: event.preparationId,
      );

      return failureOrPreparation.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPicking.failure,
            message: failure.message,
          ),
        ),
        (preparation) async {
          final failureOrPreparationDetails =
              await _findAllPreparationDetailByPreparationIdUseCase(
                id: preparation.id!,
              );

          return failureOrPreparationDetails.fold(
            (failure) => emit(
              state.copyWith(
                status: StatusPicking.failure,
                message: failure.message,
              ),
            ),
            (preparationDetails) async {
              final failureOrItems =
                  await _findAllPreparationItemByPreparationIdUseCase(
                    id: event.preparationId,
                  );

              return failureOrItems.fold(
                (failure) => emit(
                  state.copyWith(
                    status: StatusPicking.failure,
                    message: failure.message,
                    preparation: preparation,
                    preparationDetails: preparationDetails,
                    itemsPreparation: [],
                  ),
                ),
                (items) => emit(
                  state.copyWith(
                    status: StatusPicking.loaded,
                    preparation: preparation,
                    preparationDetails: preparationDetails,
                    itemsPreparation: items,
                  ),
                ),
              );
            },
          );
        },
      );
    });

    on<OnFindItemPickingDetail>((event, emit) async {
      emit(state.copyWith(status: StatusPicking.loading));

      await Future.delayed(Duration(seconds: 3));

      final failureOrPreparationDetail =
          await _findPreparationDetailByIdUseCase(
            id: event.preparationDetailId,
          );

      return failureOrPreparationDetail.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPicking.failure,
            message: failure.message,
          ),
        ),
        (preparationDetail) async {
          final failureOritemsDetail =
              await _findAllPreparationItemByPreparationDetailIdUseCase(
                id: event.preparationDetailId,
              );

          return failureOritemsDetail.fold(
            (failure) => emit(
              state.copyWith(
                status: StatusPicking.loaded,
                preparationDetail: preparationDetail,
                itemsDetail: [],
              ),
            ),
            (items) => emit(
              state.copyWith(
                status: StatusPicking.loaded,
                preparationDetail: preparationDetail,
                itemsDetail: items,
              ),
            ),
          );
        },
      );
    });

    on<OnInsertItemPicking>((event, emit) async {
      emit(state.copyWith(status: StatusPicking.loading));

      await Future.delayed(Duration(seconds: 3));

      final failureOrItem = await _createPreparationItemUseCase(
        params: event.params,
      );

      return failureOrItem.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPicking.failureInsertItem,
            message: failure.message,
          ),
        ),
        (item) async {
          final failureOrPreparationDetail =
              await _findPreparationDetailByIdUseCase(
                id: event.params.preparationDetailId!,
              );

          return failureOrPreparationDetail.fold(
            (failure) => emit(
              state.copyWith(
                status: StatusPicking.failureInsertItem,
                message: failure.message,
              ),
            ),
            (preparationDetail) async {
              final failureOrPreparationDetails =
                  await _findAllPreparationDetailByPreparationIdUseCase(
                    id: preparationDetail.preparationId!,
                  );

              return failureOrPreparationDetails.fold(
                (failure) => emit(
                  state.copyWith(
                    status: StatusPicking.failureInsertItem,
                    message: failure.message,
                  ),
                ),
                (preparationDetails) async {
                  final failureOritemsDetail =
                      await _findAllPreparationItemByPreparationDetailIdUseCase(
                        id: event.params.preparationDetailId!,
                      );

                  return failureOritemsDetail.fold(
                    (failure) => emit(
                      state.copyWith(
                        status: StatusPicking.failureInsertItem,
                        preparationDetail: preparationDetail,
                        itemsDetail: [],
                        message: failure.message,
                      ),
                    ),
                    (items) => emit(
                      state.copyWith(
                        status: StatusPicking.insertItem,
                        preparationDetail: preparationDetail,
                        preparationDetails: preparationDetails,
                        itemsDetail: items,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      );
    });

    on<OnFindAssetByAssetCodeAndLocation>((event, emit) async {
      emit(state.copyWith(status: StatusPicking.loadingFindAsset));

      await Future.delayed(Duration(seconds: 3));

      final failureOrAsset = await _findAssetByAssetCodeAndLocationUseCase(
        assetCode: event.assetCode,
        location: event.location,
      );

      failureOrAsset.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPicking.failureFindAsset,
            message: failure.message,
          ),
        ),
        (asset) => emit(
          state.copyWith(status: StatusPicking.successFindAsset, asset: asset),
        ),
      );
    });

    on<OnDeleteItemPicking>((event, emit) async {
      emit(state.copyWith(status: StatusPicking.loading));

      await Future.delayed(Duration(seconds: 3));

      final failureOrItem = await _deletePreparationItemUseCase(
        id: event.preparationItem.id!,
      );

      return failureOrItem.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPicking.failureDeleteItem,
            message: failure.message,
          ),
        ),
        (_) async {
          final preparationDetail = event.preparationDetail;
          final preparationItem = event.preparationItem;

          final newPreparationDetail = preparationDetail.copyWith(
            quantityPicked:
                preparationDetail.quantityPicked! - preparationItem.quantity!,
          );

          print(newPreparationDetail);
          final failureOrPreparationDetailUpdate =
              await _updatePreparationDetailUseCase(
                params: newPreparationDetail,
              );

          return failureOrPreparationDetailUpdate.fold(
            (failure) => emit(
              state.copyWith(
                status: StatusPicking.failureDeleteItem,
                message: failure.message,
              ),
            ),
            (_) async {
              final failureOrPreparationDetail =
                  await _findPreparationDetailByIdUseCase(
                    id: event.preparationDetail.id!,
                  );
              return failureOrPreparationDetail.fold(
                (failure) => emit(
                  state.copyWith(
                    status: StatusPicking.failureDeleteItem,
                    message: failure.message,
                  ),
                ),
                (preparationDetail) async {
                  final failureOrPreparationDetails =
                      await _findAllPreparationDetailByPreparationIdUseCase(
                        id: preparationDetail.preparationId!,
                      );

                  return failureOrPreparationDetails.fold(
                    (failure) => emit(
                      state.copyWith(
                        status: StatusPicking.failureDeleteItem,
                        message: failure.message,
                      ),
                    ),
                    (preparationDetails) async {
                      final failureOritemsDetail =
                          await _findAllPreparationItemByPreparationDetailIdUseCase(
                            id: event.preparationDetail.id!,
                          );

                      return failureOritemsDetail.fold(
                        (failure) => emit(
                          state.copyWith(
                            status: StatusPicking.failureDeleteItem,
                            preparationDetail: preparationDetail,
                            preparationDetails: preparationDetails,
                            itemsDetail: [],
                            message: failure.message,
                          ),
                        ),
                        (items) => emit(
                          state.copyWith(
                            status: StatusPicking.deleteItem,
                            preparationDetail: preparationDetail,
                            preparationDetails: preparationDetails,
                            itemsDetail: items,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      );
    });

    on<OnUpdateStatusCompletedPreparationDetail>((event, emit) async {
      emit(state.copyWith(status: StatusPicking.loading));

      await Future.delayed(Duration(seconds: 3));

      final failureOrPreparationDetail =
          await _updateStatusPreparationDetailUseCase(
            id: event.id,
            params: 'COMPLETED',
          );

      return failureOrPreparationDetail.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusPicking.failedUpdateStatusPreparationDetail,
            message: failure.message,
          ),
        ),
        (preparationDetail) async {
          final failureOrPreparationDetails =
              await _findAllPreparationDetailByPreparationIdUseCase(
                id: preparationDetail.preparationId!,
              );

          return failureOrPreparationDetails.fold(
            (failure) => emit(
              state.copyWith(
                status: StatusPicking.failedUpdateStatusPreparationDetail,
                message: failure.message,
              ),
            ),
            (preparationDetails) => emit(
              state.copyWith(
                status: StatusPicking.updateStatusPreparationDetail,
                preparationDetail: preparationDetail,
                preparationDetails: preparationDetails,
              ),
            ),
          );
        },
      );
    });

    // on<OnSubmitReadyPreparation>((event, emit) async {
    //   emit(state.copyWith(status: StatusPicking.loading));

    //   await Future.delayed(Duration(seconds: 3));

    //   final failureOrPreparation = await _updateStatusPreparationUseCase(
    //     id: event.preparationId,
    //     params: 'READY',
    //     locationId: event.locationId,
    //     totalBox: event.totalBox,
    //   );

    //   return failureOrPreparation.fold(
    //     (failure) => emit(
    //       state.copyWith(
    //         status: StatusPicking.failedReadyPreparation,
    //         message: failure.message,
    //       ),
    //     ),
    //     (preparation) async {
    //       final failureOrPreparations = await _findAllPreparationUseCase();

    //       return failureOrPreparations.fold(
    //         (failure) => emit(
    //           state.copyWith(
    //             status: StatusPicking.failedReadyPreparation,
    //             message: failure.message,
    //           ),
    //         ),
    //         (preparations) async {
    //           final failureOrNewPreparation = await _findPreparationByIdUseCase(
    //             id: event.preparationId,
    //           );

    //           final newPreparations = preparations.where((element) {
    //             return element.assignedId == event.userId &&
    //                 (element.status == 'ASSIGNED' ||
    //                     element.status == 'PICKING');
    //           }).toList();

    //           return failureOrNewPreparation.fold(
    //             (failure) => emit(
    //               state.copyWith(
    //                 status: StatusPicking.failedReadyPreparation,
    //                 message: failure.message,
    //               ),
    //             ),
    //             (newPreparation) => emit(
    //               state.copyWith(
    //                 status: StatusPicking.successReadyPreparation,
    //                 preparation: newPreparation,
    //                 preparations: newPreparations,
    //                 message: 'Successfully submit pick list',
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     },
    //   );
    // });

    // on<OnStartPicking>((event, emit) async {
    //   emit(state.copyWith(status: StatusPicking.loading));

    //   final failureOrPreparation = await _updateStatusPreparationUseCase(
    //     id: event.preparationId,
    //     params: 'PICKING',
    //   );

    //   return failureOrPreparation.fold(
    //     (failure) => emit(
    //       state.copyWith(
    //         status: StatusPicking.failedStartPicking,
    //         message: failure.message,
    //       ),
    //     ),
    //     (preparation) async {
    //       final failureOrPreparations = await _findAllPreparationUseCase();

    //       return failureOrPreparations.fold(
    //         (failure) => emit(
    //           state.copyWith(
    //             status: StatusPicking.failedStartPicking,
    //             message: failure.message,
    //           ),
    //         ),
    //         (preparations) async {
    //           final failureOrNewPreparation = await _findPreparationByIdUseCase(
    //             id: event.preparationId,
    //           );

    //           return failureOrNewPreparation.fold(
    //             (failure) => emit(
    //               state.copyWith(
    //                 status: StatusPicking.failedStartPicking,
    //                 message: failure.message,
    //               ),
    //             ),
    //             (newPreparation) => emit(
    //               state.copyWith(
    //                 status: StatusPicking.successStartPicking,
    //                 message: 'Successfully start picking',
    //                 preparation: newPreparation,
    //                 preparations: preparations
    //                     .where(
    //                       (e) =>
    //                           e.status == 'PICKING' || e.status == 'ASSIGNED',
    //                     )
    //                     .toList(),
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     },
    //   );
    // });
  }
}
