// ignore_for_file: public_member_api_docs

import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail_response.dart';
import 'package:dartz/dartz.dart';

abstract class PreparationDetailRepository {
  Future<Either<Failure, PreparationDetailResponse>> getPreparationDetails({
    required int preparationId,
  });
  Future<Either<Failure, String>> addPreparationDetail({
    required PreparationDetail params,
  });
}
