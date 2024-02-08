import 'dart:convert';

import 'package:http/http.dart' as http;

class TmdbApi {
  static Future<String> createGuestSession() async {
    final url = Uri.parse(
        'https://api.themoviedb.org/3/authentication/guest_session/new?api_key=45a1ee9c5a52396669dced36b29a6d61');
    final response = await http.post(url);
    if (response.statusCode == 200) {
      final sessionData = json.decode(response.body);
      final sessionID = sessionData['session_id'];
      return sessionID;
    } else {
      throw Exception('Failed to create guest session');
    }
  }
}
