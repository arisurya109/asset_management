import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/services/printer_service.dart';
import 'package:dartz/dartz.dart';

abstract class PrinterRepository {
  Future<Either<Failure, String>> setPrinterDefault(String ip);
  Future<Either<Failure, String>> getIpPrinter();
}

class PrinterRepositoryImpl implements PrinterRepository {
  final PrinterServices _services;

  PrinterRepositoryImpl(this._services);

  @override
  Future<Either<Failure, String>> getIpPrinter() async {
    try {
      final ipPrinter = await _services.getIpPrinter();
      return Right(ipPrinter);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> setPrinterDefault(String ip) async {
    try {
      final ipPrinter = await _services.setPrinterDefault(ip);
      return Right(ipPrinter);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
