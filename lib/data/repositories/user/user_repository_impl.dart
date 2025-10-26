import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/user/user_model.dart';
import 'package:asset_management/data/source/user/user_remote_data_source.dart';
import 'package:asset_management/domain/entities/user/user.dart';
import 'package:asset_management/domain/repositories/user/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _source;

  UserRepositoryImpl(this._source);

  @override
  Future<Either<Failure, User>> createUser(User params) async {
    try {
      final response = await _source.createUser(UserModel.fromEntity(params));
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteUser(int params) async {
    try {
      final response = await _source.deleteUser(params);
      return Right(response);
    } on DeleteException catch (e) {
      return Left(DeleteFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<User>>> findAllUser() async {
    try {
      final response = await _source.findAllUser();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> findUserById(int params) async {
    try {
      final response = await _source.findUserById(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> updateUser(User params) async {
    try {
      final response = await _source.updateUser(UserModel.fromEntity(params));
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
