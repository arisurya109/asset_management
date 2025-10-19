import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_model/data/model/asset_model_model.dart';
import 'package:asset_management/features/asset_model/data/source/asset_model_remote_data_source.dart';
import 'package:http/http.dart' as http;

class AssetModelRemoteDataSourceImpl implements AssetModelRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  AssetModelRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<AssetModelModel> createAssetModel(AssetModelModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_model'),
        body: jsonEncode(params.toJson()),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final data = body['data'];

        return AssetModelModel.fromJson(data);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<AssetModelModel>> findAllAssetModel() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_model'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List data = body['data'];

        return data.map((e) => AssetModelModel.fromJson(e)).toList();
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
