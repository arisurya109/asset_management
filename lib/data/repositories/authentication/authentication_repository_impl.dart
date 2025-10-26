import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/authentication/authentication_model.dart';
import 'package:asset_management/data/source/authentication/authentication_remote_data_source.dart';
import 'package:asset_management/domain/entities/authentication/authentication.dart';
import 'package:asset_management/domain/entities/user/user.dart';
import 'package:asset_management/domain/repositories/authentication/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _source;

  AuthenticationRepositoryImpl(this._source);

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
  Future<Either<Failure, String>> changePassword(Authentication params) async {
    try {
      final response = await _source.changePassword(
        AuthenticationModel.fromEntity(params),
      );
      return Right(response);
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> login(Authentication params) async {
    try {
      final response = await _source.login(
        AuthenticationModel.fromEntity(params),
      );
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
