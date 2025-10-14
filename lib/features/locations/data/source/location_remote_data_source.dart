// ignore_for_file: public_member_api_docs

import '../model/location_model.dart';

abstract class LocationRemoteDataSource {
  Future<List<LocationModel>> findAllLocation();
  Future<LocationModel> createLocation(LocationModel params);
  Future<LocationModel> updateLocation(LocationModel params);
}
