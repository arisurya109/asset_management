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
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/auto_login'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyData = jsonDecode(response.body);

        final data = bodyData['data'];

        return UserModel.fromJson(data);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<UserModel> login(String username, String password) async {
    final response = await _client.post(
      Uri.parse('${ApiHelper.baseUrl}/login'),
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      final token = body['token'];
      final data = body['data'];

      final isSaved = await _tokenHelper.saveToken(token);

      if (isSaved) {
        return UserModel.fromJson(data);
      } else {
        throw CreateException(message: 'Failed to login please try again');
      }
    } else {
      throw CreateException(message: ApiHelper.getErrorMessage(response.body));
    }
  }

  @override
  Future<void> logout() async {
    await _tokenHelper.removeToken();
    return;
  }
}
