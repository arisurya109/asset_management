import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/repositories/printer_repository.dart';
import 'package:dartz/dartz.dart';

class SetDefaultPrinterUseCase {
  final PrinterRepository _repository;

  SetDefaultPrinterUseCase(this._repository);

  Future<Either<Failure, String>> call(String ip) async {
    return _repository.setPrinterDefault(ip);
  }
}
