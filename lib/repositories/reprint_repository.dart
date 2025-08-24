import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../core/config/config_label.dart';
import '../core/error/exception.dart';
import '../core/error/failure.dart';
import '../services/printer_service.dart';

abstract class ReprintRepository {
  Future<Either<Failure, void>> reprintAssetIdByAssetId(String assetId);
  Future<Either<Failure, void>> reprintAssetIdBySerialNumber(
    String serialNumber,
  );
  Future<Either<Failure, void>> reprintLocation(String location);
}

class ReprintRepositoryImpl implements ReprintRepository {
  final PrinterServices _services;

  ReprintRepositoryImpl(this._services);

  @override
  Future<Either<Failure, void>> reprintAssetIdByAssetId(String assetId) async {
    try {
      final printer = await _services.getConnectionPrinter();

      debugPrint('$printer');

      final command = ConfigLabel.AssetId(assetId);

      printer.write(command);
      await printer.flush();
      await printer.close();
      return Right(null);
    } on FailedConnectedPrinterException catch (e) {
      debugPrint('$e');
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> reprintAssetIdBySerialNumber(
    String serialNumber,
  ) {
    // TODO: implement reprintAssetIdBySerialNumber
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> reprintLocation(String location) async {
    try {
      final printer = await _services.getConnectionPrinter();

      final command = ConfigLabel.Location(location);

      printer.write(command);
      await printer.flush();
      await printer.close();
      return Right(null);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
