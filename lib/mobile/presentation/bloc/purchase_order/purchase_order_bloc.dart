import 'package:asset_management/domain/entities/purchase_order/purchase_order.dart';
import 'package:asset_management/domain/entities/purchase_order/purchase_order_detail.dart';
import 'package:asset_management/domain/usecases/purchase_order/create_purchase_order_use_case.dart';
import 'package:asset_management/domain/usecases/purchase_order/find_all_asset_purchase_order_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/purchase_order/find_all_purchase_order_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'purchase_order_event.dart';
part 'purchase_order_state.dart';

class PurchaseOrderBloc extends Bloc<PurchaseOrderEvent, PurchaseOrderState> {
  final CreatePurchaseOrderUseCase _createPurchaseOrderUseCase;
  final FindAllPurchaseOrderUseCase _findAllPurchaseOrderUseCase;
  final FindAllAssetPurchaseOrderById _findAllAssetPurchaseOrderById;

  PurchaseOrderBloc(
    this._createPurchaseOrderUseCase,
    this._findAllPurchaseOrderUseCase,
    this._findAllAssetPurchaseOrderById,
  ) : super(PurchaseOrderState()) {
    on<OnCreatePurchaseOrderEvent>(_createPurchaseOrder);
    on<OnFindAllPurchaseOrderEvent>(_findAllPurchaseOrder);
    on<OnFindAllAssetPurchaseOrderEvent>(_findAllAssetPurchaseOrder);
  }

  void _createPurchaseOrder(
    OnCreatePurchaseOrderEvent event,
    Emitter<PurchaseOrderState> emit,
  ) async {
    emit(state.copyWith(status: StatusPurchaseOrder.loading));

    final failureOrPurchaseOrder = await _createPurchaseOrderUseCase(
      event.params,
    );

    return failureOrPurchaseOrder.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPurchaseOrder.failed,
          message: failure.message,
        ),
      ),
      (purchase) => emit(
        state.copyWith(
          status: StatusPurchaseOrder.success,
          purchaseOrders: [...?state.purchaseOrders, purchase],
        ),
      ),
    );
  }

  void _findAllPurchaseOrder(
    OnFindAllPurchaseOrderEvent event,
    Emitter<PurchaseOrderState> emit,
  ) async {
    emit(state.copyWith(status: StatusPurchaseOrder.loading));

    final failureOrPurchaseOrder = await _findAllPurchaseOrderUseCase();

    return failureOrPurchaseOrder.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPurchaseOrder.failed,
          message: failure.message,
        ),
      ),
      (purchases) => emit(
        state.copyWith(
          status: StatusPurchaseOrder.success,
          purchaseOrders: purchases,
        ),
      ),
    );
  }

  void _findAllAssetPurchaseOrder(
    OnFindAllAssetPurchaseOrderEvent event,
    Emitter<PurchaseOrderState> emit,
  ) async {
    emit(state.copyWith(status: StatusPurchaseOrder.loading));

    final failureOrPurchaseOrder = await _findAllAssetPurchaseOrderById(
      event.params,
    );

    return failureOrPurchaseOrder.fold(
      (failure) => emit(
        state.copyWith(
          status: StatusPurchaseOrder.failed,
          message: failure.message,
        ),
      ),
      (assets) => emit(
        state.copyWith(status: StatusPurchaseOrder.success, assets: assets),
      ),
    );
  }
}
