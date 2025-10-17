// ignore_for_file: public_member_api_docs

import 'dart:convert';

import 'package:asset_management/core/config/api_helper.dart';
import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/locations/data/model/location_model.dart';
import 'package:asset_management/features/locations/data/source/location_remote_data_source.dart';
import 'package:http/http.dart' as http;

import '../../../../services/printer_service.dart';

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final http.Client _client;
  final TokenHelper _tokenHelper;
  final PrinterServices _printerServices;

  LocationRemoteDataSourceImpl(
    this._client,
    this._tokenHelper,
    this._printerServices,
  );

  @override
  Future<LocationModel> createLocation(LocationModel params) async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.post(
        Uri.parse('${ApiHelper.baseUrl}/location'),
        headers: ApiHelper.headersToken(token),
        body: jsonEncode(params.toAPI()),
      );

      if (response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);

        final body = responseBody['data'];

        final printer = await _printerServices.getConnectionPrinter();

        final command = ConfigLabel.Location(body['name']);

        printer.write(command);

        await printer.flush();
        await printer.close();

        return LocationModel.fromAPI(body);
      } else {
        throw ApiHelper.getErrorMessage(response.body);
      }
    }
  }

  @override
  Future<List<LocationModel>> findAllLocation() async {
    final token = await _tokenHelper.getToken();

    if (token == null) {
      throw CreateException(message: 'Token expired');
    } else {
      final response = await _client.get(
        Uri.parse('${ApiHelper.baseUrl}/location'),
        headers: ApiHelper.headersToken(token),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        List body = responseBody['data'];

        return body.map((e) => LocationModel.fromAPI(e)).toList();
      } else {
        throw ApiHelper.getErrorMessage(response.body);
      }
    }
  }

  @override
  Future<LocationModel> updateLocation(LocationModel params) {
    // TODO: implement updateLocation
    throw UnimplementedError();
  }
}
