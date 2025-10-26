import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:asset_management/data/model/printer/printer_model.dart';
import 'package:asset_management/data/source/printer/printer_local_data_source.dart';
import 'package:asset_management/domain/entities/printer/printer.dart';
import 'package:asset_management/domain/repositories/printer/printer_repository.dart';

import '../../../core/core.dart';

class PrinterRepositoryImpl implements PrinterRepository {
  final PrinterLocalDataSource _source;

  PrinterRepositoryImpl(this._source);

  @override
  Future<Either<Failure, Socket>> getConnectionPrinter() async {
    try {
      final response = await _source.getConnectionPrinter();
      return Right(response);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getIpPrinter() async {
    try {
      final response = await _source.getIpPrinter();
      return Right(response);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> setDefaultPrinter(Printer params) async {
    try {
      final response = await _source.setDefaultPrinter(
        PrinterModel.fromEntity(params),
      );
      return Right(response);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
