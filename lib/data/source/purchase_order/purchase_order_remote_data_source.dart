import 'package:asset_management/data/model/purchase_order/purchase_order_detail_model.dart';
import 'package:asset_management/data/model/purchase_order/purchase_order_model.dart';

abstract class PurchaseOrderRemoteDataSource {
  Future<PurchaseOrderModel> createPurchaseOrder(PurchaseOrderModel params);
  Future<List<PurchaseOrderModel>> findAllPurchaseOrder();
  Future<List<PurchaseOrderDetailModel>> findPurchaserOrderDetailItem(
    int purchaseOrderId,
  );
}
