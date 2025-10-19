import 'package:asset_management/features/transfer/data/model/transfer_model.dart';

abstract class TransferRemoteDataSource {
  Future<String> transferAsset(TransferModel params);
}
