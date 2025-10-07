import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_registration/data/model/asset_registration_model.dart';
import 'package:asset_management/features/asset_registration/data/source/asset_registration_source.dart';
import 'package:http/http.dart' as http;

class AssetRegistrationSourceImpl implements AssetRegistrationSource {
  final http.Client _client;

  AssetRegistrationSourceImpl(this._client);

  @override
  Future<String> create(AssetRegistrationModel params) async {
    try {
      final response = await _client.post(
        Uri.parse('///POST REGISTRATION///'),
        headers: {
          'Authorization': 'Bearer //TOKEN//',
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Decode body

        // To Model and Return
        return '';
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Not found');
      } else {
        throw '//Server Exception//';
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> reRegistration(AssetRegistrationModel params) async {
    try {
      final response = await _client.post(
        Uri.parse('///POST REGISTRATION///'),
        headers: {
          'Authorization': 'Bearer //TOKEN//',
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Decode body

        // To Database or Table Baru

        // To Model and Return
        return '';
      } else if (response.statusCode == 404) {
        throw NotFoundException(message: 'Not found');
      } else {
        throw '//Server Exception//';
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<AssetRegistrationModel>> findAllAsset() {
    // TODO: implement findAllAsset
    throw UnimplementedError();
  }
}
