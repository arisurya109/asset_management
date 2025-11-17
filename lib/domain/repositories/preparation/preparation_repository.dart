import 'dart:io';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/entities/preparation/preparation_item.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

abstract class PreparationRepository {
  // Preparation
  Future<Either<Failure, List<Preparation>>> findAllPreparation();
  Future<Either<Failure, Preparation>> findPreparationById(int params);
  Future<Either<Failure, Preparation>> createPreparation(Preparation params);
  Future<Either<Failure, Preparation>> updatePreparation(Preparation params);
  Future<Either<Failure, Preparation>> dispatchPreparation(Preparation params);
  Future<Either<Failure, Preparation>> completedPreparation(
    PlatformFile file,
    Preparation params,
  );
  Future<Either<Failure, File>> getDocumentPreparationById(int params);

  // Preparation Detail
  Future<Either<Failure, PreparationDetail>> createPreparationDetail(
    PreparationDetail params,
  );
  Future<Either<Failure, List<PreparationDetail>>>
  findAllPreparationDetailByPreparationId(int params);
  Future<Either<Failure, PreparationDetail>> findPreparationDetailById(
    int preparationId,
    int params,
  );
  Future<Either<Failure, PreparationDetail>> updatePreparationDetail(
    PreparationDetail params,
  );

  // Preparation Item
  Future<Either<Failure, PreparationItem>> createPreparationItem(
    PreparationItem params,
  );
  Future<Either<Failure, List<PreparationItem>>>
  findAllPreparationItemByPreparationDetailId(int params, int preparationId);
  Future<Either<Failure, List<PreparationItem>>>
  findAllPreparationItemByPreparationId(int params);
}
