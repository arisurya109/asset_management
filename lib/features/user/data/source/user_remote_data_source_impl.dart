import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/user/data/model/user_model.dart';
import 'package:asset_management/features/user/data/source/user_remote_data_source.dart';
import 'package:http/http.dart' as http;

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final TokenHelper _tokenHelper;
  final http.Client _client;

  UserRemoteDataSourceImpl(this._tokenHelper, this._client);

  @override
  Future<UserModel> autoLogin() async {
    try {
      final token = await _tokenHelper.getToken();

      if (token == null) {
        throw CreateException(message: 'Please Login');
      } else {
        final response = await _client.get(
          Uri.parse('${ApiHelper.baseUrl}/auto_login'),
          headers: ApiHelper.headersToken(token),
        );

        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);

          return UserModel.fromResponse(body['data']);
        } else {
          final message = ApiHelper.getErrorMessage(response.body);
          throw CreateException(message: message);
        }
      }
    } catch (e) {
      throw CreateException(message: e.toString());
    }
  }

  @override
  Future<String> changePassword(
    String username,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final token = await _tokenHelper.getToken();

      final response = await _client.put(
        Uri.parse('${ApiHelper.baseUrl}/change_password'),
        headers: ApiHelper.headersToken(token!),
        body: jsonEncode({
          'username': username,
          'old_password': oldPassword,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['status'];
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw UpdateException(message: message);
      }
    } catch (e) {
      throw UpdateException(message: e.toString());
    }
  }

  @override
  Future<UserModel> login(UserModel params) async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/login'),
        headers: ApiHelper.headersNoToken,
        body: jsonEncode({
          'username': params.username,
          'password': params.password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final token = responseBody['token'];
        final data = responseBody['data'];

        final savedToken = await _tokenHelper.saveToken(token);

        if (!savedToken) {
          throw CreateException(message: 'Failed to login, please try again');
        } else {
          return UserModel.fromResponse(data);
        }
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    } catch (e) {
      throw CreateException(message: e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await _tokenHelper.removeToken();
    return;
  }
}
