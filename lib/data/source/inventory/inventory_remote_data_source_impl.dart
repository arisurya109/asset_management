import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/data/model/inventory/inventory_model.dart';
import 'package:asset_management/data/source/inventory/inventory_remote_data_source.dart';
import 'package:http/http.dart' as http;

class InventoryRemoteDataSourceImpl implements InventoryRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  InventoryRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<InventoryModel> findInventory(String params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/inventory?location=$params'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return InventoryModel.fromJson(datas);
      } else {
        throw NotFoundException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
