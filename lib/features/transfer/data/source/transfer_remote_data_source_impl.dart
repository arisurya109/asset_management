import 'dart:convert';

import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/features/transfer/data/model/transfer_model.dart';
import 'package:asset_management/features/transfer/data/source/transfer_remote_data_source.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/api_helper.dart';
import '../../../../core/core.dart';

class TransferRemoteDataSourceImpl implements TransferRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  TransferRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<String> transferAsset(TransferModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_transfer/'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      final body = jsonDecode(response.body);

      final datas = body['data'];

      if (response.statusCode == 201) {
        return '${datas['asset']['code']} To ${datas['to_location']['name']}';
      } else {
        throw ApiHelper.getErrorMessage(response.body);
      }
    }
  }
}
