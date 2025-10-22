import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/vendor/data/model/vendor_model.dart';
import 'package:asset_management/features/vendor/data/source/vendor_remote_data_source.dart';
import 'package:asset_management/features/vendor/domain/entities/vendor.dart';
import 'package:asset_management/features/vendor/domain/repositories/vendor_repository.dart';
import 'package:dartz/dartz.dart';

class VendorRepositoryImpl implements VendorRepository {
  final VendorRemoteDataSource _source;

  VendorRepositoryImpl(this._source);

  @override
  Future<Either<Failure, Vendor>> createVendor(Vendor params) async {
    try {
      final response = await _source.createVendor(
        VendorModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Vendor>>> findAllVendor() async {
    try {
      final response = await _source.findAllVendor();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Vendor>> updateVendor(Vendor params) async {
    try {
      final response = await _source.updateVendor(
        VendorModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
