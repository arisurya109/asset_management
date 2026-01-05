import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/data/model/movement/movement_model.dart';
import 'package:asset_management/data/source/movement/movement_remote_data_source.dart';
import 'package:http/http.dart' as http;

class MovementRemoteDataSourceImpl implements MovementRemoteDataSource {
  final TokenHelper _tokenHelper;
  final http.Client _client;

  MovementRemoteDataSourceImpl(this._tokenHelper, this._client);

  @override
  Future<String> createMovement(MovementModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse(
          '${ApiHelper.baseUrl}/asset/${params.assetId}?movement=${params.type}',
        ),
        body: jsonEncode(params.toJson()),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final status = body['status'];

        return status;
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
