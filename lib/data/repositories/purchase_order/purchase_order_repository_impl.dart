import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/purchase_order/purchase_order_model.dart';
import 'package:asset_management/data/source/purchase_order/purchase_order_remote_data_source.dart';
import 'package:asset_management/domain/entities/purchase_order/purchase_order.dart';
import 'package:asset_management/domain/entities/purchase_order/purchase_order_detail.dart';
import 'package:asset_management/domain/repositories/purchase_order/purchase_order_repository.dart';
import 'package:dartz/dartz.dart';

class PurchaseOrderRepositoryImpl implements PurchaseOrderRepository {
  final PurchaseOrderRemoteDataSource _source;

  PurchaseOrderRepositoryImpl(this._source);

  @override
  Future<Either<Failure, PurchaseOrder>> createPurchaseOrder(
    PurchaseOrder params,
  ) async {
    try {
      final response = await _source.createPurchaseOrder(
        PurchaseOrderModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseOrderDetail>>>
  findAllAssetPurchaseOrderById(int params) async {
    try {
      final response = await _source.findPurchaserOrderDetailItem(params);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseOrder>>> findAllPurchaseOrder() async {
    try {
      final response = await _source.findAllPurchaseOrder();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
