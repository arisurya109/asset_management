// ignore_for_file: public_member_api_docs

import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStatusPreparationUseCase {
  UpdateStatusPreparationUseCase(this._repository);

  final PreparationRepository _repository;

  Future<Either<Failure, Preparation>> call({
    required int id,
    required String status,
    int? totalBox,
    int? locationId,
    String? remarks,
  }) async {
    return _repository.updateStatusPreparation(
      id: id,
      status: status,
      totalBox: totalBox,
      locationId: locationId,
      remarks: remarks,
    );
  }
}
