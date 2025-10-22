// ignore_for_file: public_member_api_docs

import '../model/vendor_model.dart';

abstract class VendorRemoteDataSource {
  Future<VendorModel> createVendor(VendorModel params);
  Future<VendorModel> updateVendor(VendorModel params);
  Future<List<VendorModel>> findAllVendor();
}
