import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/purchase_order/purchase_order_detail.dart';
import 'package:asset_management/domain/repositories/purchase_order/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetPurchaseOrderById {
  final PurchaseOrderRepository _repository;

  FindAllAssetPurchaseOrderById(this._repository);

  Future<Either<Failure, List<PurchaseOrderDetail>>> call(int params) async {
    return _repository.findAllAssetPurchaseOrderById(params);
  }
}
