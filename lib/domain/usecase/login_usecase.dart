import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginUseCase {
  Future<String> login(String username, String password) async {
    String apiKey = '45a1ee9c5a52396669dced36b29a6d61';

    String requestTokenUrl =
        'https://api.themoviedb.org/3/authentication/token/new?api_key=$apiKey';
    var response = await http.get(Uri.parse(requestTokenUrl));
    if (response.statusCode == 200) {
      var requestToken = jsonDecode(response.body)['request_token'];

      String authenticateUrl =
          'https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$apiKey';
      var authenticateResponse =
          await http.post(Uri.parse(authenticateUrl), body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      });
      if (authenticateResponse.statusCode == 200) {
        String sessionUrl =
            'https://api.themoviedb.org/3/authentication/session/new?api_key=$apiKey';
        var sessionResponse = await http.post(Uri.parse(sessionUrl), body: {
          'request_token': requestToken,
        });
        if (sessionResponse.statusCode == 200) {
          var sessionId = jsonDecode(sessionResponse.body)['session_id'];

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('session_id', sessionId);
          return sessionId;
        } else {
          throw 'Failed to create session ID';
        }
      } else {
        throw 'Failed to authenticate';
      }
    } else {
      throw 'Failed to get request token';
    }
  }
}
