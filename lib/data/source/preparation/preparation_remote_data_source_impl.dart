// ignore_for_file: implementation_imports

import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source.dart';
import 'package:http/http.dart' as http;

import '../../../core/error/exception.dart';

class PreparationRemoteDataSourceImpl implements PreparationRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  PreparationRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<PreparationModel> createPreparation({
    required PreparationModel params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/preparation'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 201) {
        final decoded = jsonDecode(response.body);

        final data = decoded['data'];

        return PreparationModel.fromJSON(data);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<List<PreparationModel>> findAllPreparation() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        List datas = bodyResponse['data'];

        return datas.map((e) => PreparationModel.fromJSON(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<PreparationModel> findPreparationById({required int id}) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation?id=$id'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        final data = bodyResponse['data'];

        return PreparationModel.fromJSON(data);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<List<PreparationModel>> findPreparationByCodeOrDestination({
    required String params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/preparation?query=$params'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        List data = bodyResponse['data'];

        return data.map((e) => PreparationModel.fromJSON(e)).toList();
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw NotFoundException(message: message);
      }
    }
  }

  @override
  Future<PreparationModel> updateStatusPreparation({
    required int id,
    required String status,
    int? totalBox,
    int? locationId,
    String? remarks,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.patch(
        Uri.parse('${ApiHelper.baseUrl}/preparation?id=$id'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode({
          'status': status,
          'location_id': locationId,
          'remarks': remarks,
          'total_box': totalBox,
        }),
      );

      if (response.statusCode == 200) {
        final bodyResponse = jsonDecode(response.body);
        final data = bodyResponse['data'];

        return PreparationModel.fromJSON(data);
      } else {
        final message = ApiHelper.getErrorMessage(response.body);
        throw UpdateException(message: message);
      }
    }
  }
}
