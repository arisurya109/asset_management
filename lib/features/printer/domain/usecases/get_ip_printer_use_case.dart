import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/printer/domain/repositories/printer_repository.dart';
import 'package:dartz/dartz.dart';

class GetIpPrinterUseCase {
  final PrinterRepository _repository;

  GetIpPrinterUseCase(this._repository);

  Future<Either<Failure, String>> call() async {
    return _repository.getIpPrinter();
  }
}
