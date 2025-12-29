import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/user/user_model.dart';
import 'package:asset_management/data/source/user/user_remote_data_source.dart';
import 'package:http/http.dart' as http;

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  UserRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<UserModel> createUser(UserModel params) async {
    try {
      final token = await _tokenHelper.getToken();

      if (token == null) {
        throw CreateException(message: 'Token Expired');
      } else {
        final response = await _client.post(
          Uri.parse('${ApiHelper.baseUrl}/user'),
          headers: ApiHelper.headersToken(token),
          body: jsonEncode(params.toJson()),
        );

        if (response.statusCode == 201) {
          final body = jsonDecode(response.body);

          final datas = body['data'];

          return UserModel.fromJson(datas);
        } else {
          final message = ApiHelper.getErrorMessage(response.body);
          throw CreateException(message: message);
        }
      }
    } on CreateException catch (_) {
      rethrow;
    } catch (e) {
      throw CreateException(message: e.toString());
    }
  }

  @override
  Future<String> deleteUser(int params) async {
    try {
      final token = await _tokenHelper.getToken();

      if (token == null) {
        throw DeleteException(message: 'Token Expired');
      } else {
        final response = await _client.delete(
          Uri.parse('${ApiHelper.baseUrl}/user/$params'),
          headers: ApiHelper.headersToken(token),
        );

        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);

          final datas = body['status'];

          return datas;
        } else {
          final message = ApiHelper.getErrorMessage(response.body);
          throw DeleteException(message: message);
        }
      }
    } catch (e) {
      throw DeleteException(message: e.toString());
    }
  }

  @override
  Future<List<UserModel>> findAllUser() async {
    try {
      final token = await _tokenHelper.getToken();

      if (token == null) {
        throw NotFoundException(message: 'Token Expired');
      } else {
        final response = await _client.get(
          Uri.parse('${ApiHelper.baseUrl}/user'),
          headers: ApiHelper.headersToken(token),
        );

        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);

          List datas = body['data'];

          return datas.map((e) => UserModel.fromJson(e)).toList();
        } else {
          final message = ApiHelper.getErrorMessage(response.body);
          throw NotFoundException(message: message);
        }
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<UserModel> findUserById(int params) async {
    try {
      final token = await _tokenHelper.getToken();

      if (token == null) {
        throw NotFoundException(message: 'Token Expired');
      } else {
        final response = await _client.get(
          Uri.parse('${ApiHelper.baseUrl}/user/$params'),
          headers: ApiHelper.headersToken(token),
        );

        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);

          Map<String, dynamic> datas = body['data'];

          return UserModel.fromJson(datas);
        } else {
          final message = ApiHelper.getErrorMessage(response.body);
          throw NotFoundException(message: message);
        }
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<UserModel> updateUser(UserModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw UpdateException(message: 'Token Expired');
    } else {
      final response = await _client.patch(
        Uri.parse('${ApiHelper.baseUrl}/user/${params.id}'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        Map<String, dynamic> datas = body['data'];

        return UserModel.fromJson(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw UpdateException(message: message);
      }
    }
  }
}
