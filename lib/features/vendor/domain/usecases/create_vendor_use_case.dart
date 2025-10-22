// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/vendor.dart';
import '../repositories/vendor_repository.dart';

class CreateVendorUseCase {
  CreateVendorUseCase(this._repository);

  final VendorRepository _repository;

  Future<Either<Failure, Vendor>> call(Vendor params) async {
    return _repository.createVendor(params);
  }
}
