import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/printer/printer.dart';
import 'package:asset_management/domain/repositories/printer/printer_repository.dart';
import 'package:dartz/dartz.dart';

class SetDefaultPrinterUseCase {
  final PrinterRepository _repository;

  SetDefaultPrinterUseCase(this._repository);

  Future<Either<Failure, String>> call(Printer params) async {
    return _repository.setDefaultPrinter(params);
  }
}
