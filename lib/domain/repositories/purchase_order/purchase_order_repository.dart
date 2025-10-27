import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/purchase_order/purchase_order.dart';
import 'package:asset_management/domain/entities/purchase_order/purchase_order_detail.dart';
import 'package:dartz/dartz.dart';

abstract class PurchaseOrderRepository {
  Future<Either<Failure, PurchaseOrder>> createPurchaseOrder(
    PurchaseOrder params,
  );
  Future<Either<Failure, List<PurchaseOrder>>> findAllPurchaseOrder();
  Future<Either<Failure, List<PurchaseOrderDetail>>>
  findAllAssetPurchaseOrderById(int params);
}
