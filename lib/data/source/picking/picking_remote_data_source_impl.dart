import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/data/model/picking/picking_detail_response_model.dart';
import 'package:asset_management/data/model/picking/picking_model.dart';
import 'package:asset_management/data/source/picking/picking_remote_data_source.dart';
import 'package:asset_management/domain/entities/picking/picking_request.dart';
import 'package:http/http.dart' as http;

class PickingRemoteDataSourceImpl implements PickingRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  PickingRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<String> addPickAssetPicking({required PickingRequest params}) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse(
          '${ApiHelper.baseUrl}/picking/pick/detail/${params.preparationDetailId}',
        ),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toJsonAdd()),
      );

      if (response.statusCode == 201) {
        final body = jsonDecode(response.body);

        Map<String, dynamic> datas = body;

        return datas['status'];
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

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
  Future<PickingDetailResponseModel> pickingDetailById({
    required int params,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/picking/$params'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        Map<String, dynamic> datas = body['data'];

        return PickingDetailResponseModel.fromJson(datas);
      } else {
        throw CreateException(
          message: ApiHelper.getErrorMessage(response.body),
        );
      }
    }
  }

  @override
  Future<String> updateStatusPicking({required PickingRequest params}) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Sesi berakhir, silakan login kembali');
    }

    final paramsJson = params.status == 'PICKING'
        ? params.toJsonStatusPicking()
        : params.toJsonStatusReady();

    try {
      final response = await _client
          .patch(
            Uri.parse('${ApiHelper.baseUrl}/picking/${params.preparationId}'),
            headers: ApiHelper.headersToken(token),
            body: jsonEncode(paramsJson),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return body['status'];
      } else {
        final errorMessage = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: errorMessage);
      }
    } on SocketException {
      throw CreateException(
        message: 'Gagal terhubung ke server. Periksa koneksi internet Anda.',
      );
    } on TimeoutException {
      throw CreateException(
        message: 'Server terlalu lama merespon. Silakan coba lagi nanti.',
      );
    } on FormatException {
      throw CreateException(message: 'Format respon dari server tidak sesuai.');
    } catch (e) {
      if (e is CreateException) rethrow;
      throw CreateException(
        message: 'Terjadi kesalahan sistem: ${e.toString()}',
      );
    }
  }
}
