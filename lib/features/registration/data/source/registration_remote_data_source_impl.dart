import 'dart:convert';

import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/features/registration/data/model/registration_model.dart';
import 'package:asset_management/features/registration/data/source/registration_remote_data_source.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/api_helper.dart';
import '../../../../core/core.dart';

class RegistrationRemoteDataSourceImpl implements RegistrationRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  RegistrationRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<String> registrationAssetConsumable(RegistrationModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Expired token');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/assets/'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return '${datas['model']}, Quantity : ${datas['quantity']}';
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<String> registrationAssetNonConsumable(
    RegistrationModel params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Expired token');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/assets/'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return datas['asset_code'];
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }
}
