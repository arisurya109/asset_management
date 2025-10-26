import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/vendor.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class CreateVendorUseCase {
  final MasterRepository _repository;

  CreateVendorUseCase(this._repository);

  Future<Either<Failure, Vendor>> call(Vendor params) async {
    return _repository.createVendor(params);
  }
}
