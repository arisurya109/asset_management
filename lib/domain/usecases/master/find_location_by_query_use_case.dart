import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/location.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindLocationByQueryUseCase {
  final MasterRepository _repository;

  FindLocationByQueryUseCase(this._repository);

  Future<Either<Failure, List<Location>>> call(String query) async {
    return _repository.findLocationByQuery(query);
  }
}
