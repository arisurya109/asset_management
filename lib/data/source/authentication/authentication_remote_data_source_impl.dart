import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';

import '../../model/authentication/authentication_model.dart';
import '../../model/user/user_model.dart';
import 'authentication_remote_data_source.dart';
import 'package:http/http.dart' as http;

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  AuthenticationRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<String> changePassword(AuthenticationModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw UpdateException(message: 'Token expired');
    } else {
      final response = await _client.put(
        Uri.parse('${ApiHelper.baseUrl}/change_password'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final message = body['status'] as String;
        return message;
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw UpdateException(message: message);
      }
    }
  }

  @override
  Future<UserModel> login(AuthenticationModel params) async {
    final response = await _client.post(
      Uri.parse('${ApiHelper.baseUrl}/login'),
      body: jsonEncode(params.toJson()),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final datas = responseBody['data'];
      final token = responseBody['token'];

      final tokenSaved = await _tokenHelper.saveToken(token);

      if (!tokenSaved) {
        throw CreateException(message: 'Failed login, please try again');
      } else {
        return UserModel.fromJson(datas);
      }
    } else {
      final message = ApiHelper.getErrorMessage(response.body);
      throw CreateException(message: message);
    }
  }

  @override
  Future<void> logout() async {
    await _tokenHelper.removeToken();
    return;
  }

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
}
