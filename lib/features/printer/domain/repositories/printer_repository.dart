import 'package:asset_management/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PrinterRepository {
  Future<Either<Failure, String>> setDefaultPrinter(
    String ip, {
    int port = 9100,
  });

  Future<Either<Failure, String>> getIpPrinter();
}
