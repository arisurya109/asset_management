import 'dart:io';

import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/repositories/printer/printer_repository.dart';
import 'package:dartz/dartz.dart';

class GetConnectionPrinterUseCase {
  final PrinterRepository _repository;

  GetConnectionPrinterUseCase(this._repository);

  Future<Either<Failure, Socket>> call() async {
    return _repository.getConnectionPrinter();
  }
}
