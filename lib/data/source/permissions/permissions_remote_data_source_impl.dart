import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/config/api_helper.dart';
import '../../../core/config/token_helper.dart';
import '../../../core/core.dart';
import '../../model/permissions/permissions_model.dart';
import 'permissions_remote_data_source.dart';

class PermissionsRemoteDataSourceImpl implements PermissionsRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;
  PermissionsRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<List<PermissionsModel>> findAllPermissions() async {
    try {
      final token = await _tokenHelper.getToken();

      if (token == null) {
        throw NotFoundException(message: 'Token expired');
      }

      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/module'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final List<dynamic> datas = body['data'] ?? [];

        return datas
            .map((e) => PermissionsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    } catch (e) {
      if (e is NotFoundException) rethrow;
      throw NotFoundException(message: e.toString());
    }
  }
}
