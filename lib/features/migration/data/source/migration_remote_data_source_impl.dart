// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/features/migration/data/model/migration_model.dart';
import 'package:asset_management/features/migration/data/source/migration_remote_data_source.dart';

import '../../../../core/config/api_helper.dart';
import '../../../../core/core.dart';

class MigrationRemoteDataSourceImpl implements MigrationRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  MigrationRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<String> migrationAssetIdOld(MigrationModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Expired token');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_migration/'),
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
