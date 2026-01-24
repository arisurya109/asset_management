abstract class ReprintRemoteDataSource {
  Future<Map<String, dynamic>> reprintAssetOrLocation({
    required String params,
    required String type,
  });
}
