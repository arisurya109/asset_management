import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/data/source/reprint/reprint_remote_data_source.dart';
import 'package:http/http.dart ' as http;

class ReprintRemoteDataSourceImpl implements ReprintRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;

  ReprintRemoteDataSourceImpl(this._client, this._tokenHelper);

  @override
  Future<Map<String, dynamic>> reprintAssetOrLocation({
    required String params,
    required String type,
  }) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw NotFoundException(message: 'Sesi berakhir, silakan login kembali');
    }

    try {
      final response = await _client
          .get(
            Uri.parse('${ApiHelper.baseUrl}/reprint?type=$type&query=$params'),
            headers: ApiHelper.headersToken(token),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        return body['data'];
      } else {
        final errorMessage = ApiHelper.getErrorMessage(response.body);
        throw CreateException(message: errorMessage);
      }
    } on SocketException {
      throw CreateException(
        message: 'Failed connect to server. please check your connection.',
      );
    } on TimeoutException {
      throw CreateException(message: 'Please try again.');
    } catch (e) {
      if (e is CreateException) rethrow;
      throw CreateException(message: 'An occured : ${e.toString()}');
    }
  }
}
