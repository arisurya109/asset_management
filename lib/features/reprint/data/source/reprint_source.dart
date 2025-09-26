abstract class ReprintSource {
  Future<void> reprintAssetIdNormal(String params);
  Future<void> reprintAssetIdLarge(String params);
  Future<void> reprintAssetIdNormalBySerialNumber(String params);
  Future<void> reprintAssetIdLargeBySerialNumber(String params);
  Future<void> reprintLocation(String params);
}
