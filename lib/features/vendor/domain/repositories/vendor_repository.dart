// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/vendor.dart';

abstract class VendorRepository {
  Future<Either<Failure, Vendor>> createVendor(Vendor params);
  Future<Either<Failure, Vendor>> updateVendor(Vendor params);
  Future<Either<Failure, List<Vendor>>> findAllVendor();
}
