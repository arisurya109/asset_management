import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/transfer/domain/entities/transfer.dart';
import 'package:dartz/dartz.dart';

abstract class TransferRepository {
  Future<Either<Failure, String>> transferAsset(Transfer params);
}
