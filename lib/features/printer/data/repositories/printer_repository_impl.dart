import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/printer/data/source/printer_source.dart';
import 'package:asset_management/features/printer/domain/repositories/printer_repository.dart';
import 'package:dartz/dartz.dart';

class PrinterRepositoryImpl implements PrinterRepository {
  final PrinterSource _source;

  PrinterRepositoryImpl(this._source);

  @override
  Future<Either<Failure, String>> setDefaultPrinter(
    String ip, {
    int port = 9100,
  }) async {
    try {
      final response = await _source.setDefaultPrinter(ip);
      return Right(response);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> getIpPrinter() async {
    try {
      final result = await _source.getIpPrinter();
      return Right(result);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
