import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/vendor/data/model/vendor_model.dart';
import 'package:asset_management/features/vendor/data/source/vendor_remote_data_source.dart';
import 'package:http/http.dart' as http;

class VendorRemoteDataSourceImpl implements VendorRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  VendorRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<VendorModel> createVendor(VendorModel params) async {
    try {
      final token = await _tokenHelper.getToken();

      if (token == null) {
        throw CreateException(message: 'Token expired');
      } else {
        final response = await _client.post(
          Uri.parse('${ApiHelper.baseUrl}/vendor'),
          headers: ApiHelper.headersToken(token),
          body: jsonEncode(params.toJson()),
        );

        if (response.statusCode == 201) {
          final body = jsonDecode(response.body);

          final datas = body['data'];

          return VendorModel.fromJson(datas);
        } else {
          throw CreateException(
            message: ApiHelper.getErrorMessage(response.body),
          );
        }
      }
    } catch (e) {
      throw CreateException(message: e.toString());
    }
  }

  @override
  Future<List<VendorModel>> findAllVendor() async {
    try {
      final token = await _tokenHelper.getToken();

      if (token == null) {
        throw NotFoundException(message: 'Token expired');
      } else {
        final response = await _client.get(
          Uri.parse('${ApiHelper.baseUrl}/vendor'),
          headers: ApiHelper.headersToken(token),
        );

        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);

          List datas = body['data'];

          return datas.map((e) => VendorModel.fromJson(e)).toList();
        } else {
          throw NotFoundException(
            message: ApiHelper.getErrorMessage(response.body),
          );
        }
      }
    } catch (e) {
      throw NotFoundException(message: e.toString());
    }
  }

  @override
  Future<VendorModel> updateVendor(VendorModel params) async {
    try {
      final token = await _tokenHelper.getToken();

      if (token == null) {
        throw UpdateException(message: 'Token expired');
      } else {
        final response = await _client.patch(
          Uri.parse('${ApiHelper.baseUrl}/vendor/${params.id}'),
          headers: ApiHelper.headersToken(token),
          body: jsonEncode(params.toJson()),
        );

        if (response.statusCode == 200) {
          final body = jsonDecode(response.body);

          final datas = body['data'];

          return VendorModel.fromJson(datas);
        } else {
          throw UpdateException(
            message: ApiHelper.getErrorMessage(response.body),
          );
        }
      }
    } catch (e) {
      throw UpdateException(message: e.toString());
    }
  }
}
