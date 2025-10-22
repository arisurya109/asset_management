// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/vendor.dart';
import '../repositories/vendor_repository.dart';

class FindAllVendorUseCase {
  FindAllVendorUseCase(this._repository);

  final VendorRepository _repository;

  Future<Either<Failure, List<Vendor>>> call() async {
    return _repository.findAllVendor();
  }
}
