import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/modules/asset_transfer/data/model/asset_transfer_model.dart';
import 'package:asset_management/features/modules/asset_transfer/data/source/asset_transfer_remote_data_source.dart';
import 'package:http/http.dart' as http;

class AssetTransferRemoteDataSourceImpl
    implements AssetTransferRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  AssetTransferRemoteDataSourceImpl(this._client, this._tokenHelper);
  @override
  Future<String> createAssetTransfer(AssetTransferModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_transfer/'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        return 'Successfully Transfer ${params.assetCode} To ${params.toLocation}';
      } else {
        throw ApiHelper.getErrorMessage(response.body);
      }
    }
  }
}
