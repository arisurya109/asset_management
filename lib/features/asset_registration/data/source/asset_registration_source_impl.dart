import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_registration/data/model/asset_registration_model.dart';
import 'package:asset_management/features/asset_registration/data/source/asset_registration_source.dart';
import 'package:asset_management/services/printer_service.dart';
import 'package:http/http.dart' as http;

class AssetRegistrationSourceImpl implements AssetRegistrationSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;
  final PrinterServices _services;

  AssetRegistrationSourceImpl(this._client, this._tokenHelper, this._services);

  @override
  Future<AssetRegistrationModel> createAssetRegistration(
    AssetRegistrationModel params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Expired token');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_migration/'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toAPI()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        final printer = await _services.getConnectionPrinter();

        final command = ConfigLabel.AssetIdNormal(datas['asset_code']);

        printer.write(command);
        await printer.flush();
        await printer.close();

        return AssetRegistrationModel.fromAPI(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<AssetRegistrationModel> createAssetRegistrationConsumable(
    AssetRegistrationModel params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Expired token');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/asset_migration/'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toAPI()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        return AssetRegistrationModel.fromAPI(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<List<AssetRegistrationModel>> findAllAssetRegistration() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Expired token');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/asset_migration/'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List<dynamic> datas = body['data'];

        return datas.map((e) => AssetRegistrationModel.fromAPI(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }

  @override
  Future<AssetRegistrationModel> migrationAsset(
    AssetRegistrationModel params,
  ) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Expired token');
    } else {
      final response = await _client.patch(
        Uri.parse('${ApiHelper.baseUrl}/asset_migration/'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toAPI()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        final datas = body['data'];

        final printer = await _services.getConnectionPrinter();

        final command = ConfigLabel.AssetIdNormal(datas['asset_code']);

        printer.write(command);
        await printer.flush();
        await printer.close();

        return AssetRegistrationModel.fromAPI(datas);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: message);
      }
    }
  }
}
