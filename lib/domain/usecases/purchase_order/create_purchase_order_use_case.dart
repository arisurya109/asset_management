import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/purchase_order/purchase_order.dart';
import 'package:asset_management/domain/repositories/purchase_order/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePurchaseOrderUseCase {
  final PurchaseOrderRepository _repository;

  CreatePurchaseOrderUseCase(this._repository);

  Future<Either<Failure, PurchaseOrder>> call(PurchaseOrder params) async {
    return _repository.createPurchaseOrder(params);
  }
}
