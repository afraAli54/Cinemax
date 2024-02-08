import 'dart:convert';

import 'package:cinemax/data/core/api_constants.dart';
import 'package:cinemax/data/core/unathorised_exception.dart';
import 'package:http/http.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path, Map<dynamic, dynamic> params) async {
    final response = await _client.get(
      getPath(path, params) as Uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic post(String path, {required Map<String, dynamic> params}) async {
    final response = await _client
        .post(getPath(path, params) as Uri, body: jsonEncode(params), headers: {
      'Content-Type': 'application/json',
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw UnauthorisedException();
    }
  }

  String getPath(String path, Map<dynamic, dynamic> params) {
    var paramsString = '';
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        paramsString += '&$key=$value';
      });
    }

    return '${ApiConstants.BASE_URL}$path?api_key=${ApiConstants.API_KEY}$paramsString';
  }
}
