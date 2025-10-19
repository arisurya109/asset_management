import 'package:asset_management/features/registration/data/model/registration_model.dart';

abstract class RegistrationRemoteDataSource {
  Future<String> registrationAssetNonConsumable(RegistrationModel params);
  Future<String> registrationAssetConsumable(RegistrationModel params);
}
