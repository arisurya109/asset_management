import 'package:asset_management/features/transfer/data/source/transfer_remote_data_source.dart';
import 'package:asset_management/features/transfer/domain/entities/transfer.dart';
import 'package:asset_management/features/transfer/domain/repositories/transfer_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../model/transfer_model.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferRemoteDataSource _source;

  TransferRepositoryImpl(this._source);

  @override
  Future<Either<Failure, String>> transferAsset(Transfer params) async {
    try {
      final response = await _source.transferAsset(
        TransferModel.fromEntity(params),
      );
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
