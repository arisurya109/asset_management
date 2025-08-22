class NotFoundException implements Exception {
  String? message;

  NotFoundException({this.message});
}

class CreateException implements Exception {
  String? message;

  CreateException({this.message});
}

class UpdateException implements Exception {
  String? message;

  UpdateException({this.message});
}

class DeleteException implements Exception {
  String? message;

  DeleteException({this.message});
}

class FailedConnectedPrinterException implements Exception {
  String? message;

  FailedConnectedPrinterException({this.message});
}
