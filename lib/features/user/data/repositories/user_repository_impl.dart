import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/user/data/model/user_model.dart';
import 'package:asset_management/features/user/data/source/user_remote_data_source.dart';
import 'package:asset_management/features/user/domain/entities/user.dart';
import 'package:asset_management/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _source;

  UserRepositoryImpl(this._source);

  @override
  Future<Either<Failure, User>> autoLogin() async {
    try {
      final response = await _source.autoLogin();
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> changePassword(
    String username,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final response = await _source.changePassword(
        username,
        oldPassword,
        newPassword,
      );
      return Right(response);
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> login(User params) async {
    try {
      final response = await _source.login(UserModel.fromEntity(params));
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final response = await _source.logout();
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
