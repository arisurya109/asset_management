import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/vendor.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllVendorUseCase {
  final MasterRepository _repository;

  FindAllVendorUseCase(this._repository);

  Future<Either<Failure, List<Vendor>>> call() async {
    return _repository.findAllVendor();
  }
}
