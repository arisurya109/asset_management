import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/data/model/picking/picking_detail_item_model.dart';
import 'package:asset_management/data/model/picking/picking_detail_response_model.dart';
import 'package:asset_management/data/model/picking/picking_model.dart';
import 'package:asset_management/data/source/picking/picking_remote_data_source.dart';
import 'package:http/http.dart' as http;

class PickingRemoteDataSourceImpl implements PickingRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  PickingRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<List<PickingModel>> findAllPickingTask() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/picking'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        List datas = body['data'];

        return datas.map((e) => PickingModel.fromJson(e)).toList();
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<PickingDetailResponseModel> findPickingDetail({
    required int id,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/picking/$id'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        return PickingDetailResponseModel.fromMap(body['data']);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<String> pickedAsset({required PickingDetailItemModel params}) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.patch(
        Uri.parse('${ApiHelper.baseUrl}/picking'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJson()),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        return body['status'];
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<String> updateStatusPicking({
    required int id,
    required String params,
    int? temporaryLocationId,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      Map<String, dynamic> json = {'status': params};

      if (temporaryLocationId != null) {
        json.addAll({'temporary_location_id': temporaryLocationId});
      }

      final response = await _client.patch(
        Uri.parse('${ApiHelper.baseUrl}/picking/$id'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(json),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        return body['status'];
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }
}
