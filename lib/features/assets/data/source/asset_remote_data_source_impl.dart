import 'dart:convert';

import 'package:asset_management/features/assets/data/model/asset_detail_model.dart';
import 'package:asset_management/features/assets/data/source/asset_remote_data_source.dart';
import 'package:http/http.dart' as http;

import '../../../../core/config/api_helper.dart';
import '../../../../core/config/token_helper.dart';
import '../../../../core/core.dart';
import '../model/asset_model.dart';

class AssetsRemoteDataSourceImpl implements AssetsRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  AssetsRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<List<AssetsModel>> findAllAsset() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/assets/'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas.map((e) => AssetsModel.fromMap(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<AssetDetailModel>> findAssetDetailById(int params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_history/$params'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas.map((e) => AssetDetailModel.fromJson(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
