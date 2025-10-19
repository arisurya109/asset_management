import 'dart:io';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/printer/domain/entities/printer.dart';
import 'package:dartz/dartz.dart';

abstract class PrinterRepository {
  Future<Either<Failure, String>> setDefaultPrinter(Printer params);
  Future<Either<Failure, String>> getIpPrinter();
  Future<Either<Failure, Socket>> getConnectionPrinter();
}
