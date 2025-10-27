import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/purchase_order/purchase_order.dart';
import 'package:asset_management/domain/repositories/purchase_order/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPurchaseOrderUseCase {
  final PurchaseOrderRepository _repository;

  FindAllPurchaseOrderUseCase(this._repository);

  Future<Either<Failure, List<PurchaseOrder>>> call() async {
    return _repository.findAllPurchaseOrder();
  }
}
