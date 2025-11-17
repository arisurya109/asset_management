import 'dart:convert';

class ApiHelper {
  static const String _url = 'http://192.168.0.5';
  static const String _port = '8080';
  static const String baseUrl = '$_url:$_port/api';

  static const Map<String, String> headersNoToken = {
    'Content-Type': 'application/json',
  };

  static Map<String, String> headersToken(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  static String getErrorMessage(String body) {
    final errorBody = jsonDecode(body);
    return errorBody['error']['description'];
  }
}
