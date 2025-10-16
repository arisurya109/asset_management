import 'dart:convert';

import '../../../../../core/config/api_helper.dart';
import '../../../../../core/config/token_helper.dart';
import '../../../../../core/core.dart';
import '../model/asset_inventory_model.dart';
import 'inventory_remote_data_source.dart';

import 'package:http/http.dart' as http;

class InventoryRemoteDataSourceImpl implements InventoryRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  InventoryRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<List<InventoryModel>> findAllAssetInventory() async {
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

        return datas.map((e) => InventoryModel.fromMap(e)).toList();
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
