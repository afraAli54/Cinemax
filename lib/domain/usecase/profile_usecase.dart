import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cinemax/domain/model/user_model.dart';

class ProfileUseCase {
  Future<String?> getSessionId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('session_id');
  }

  Future<User> fetchUserData() async {
    final apiKey =
        'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0NWExZWU5YzVhNTIzOTY2NjlkY2VkMzZiMjlhNmQ2MSIsInN1YiI6IjY1YzMzMDVhOTVhY2YwMDE2MjFjMTkyOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.HZuafUc_RInT-PAK9Qx4FqcEZcLaJ0kwVc-9Y5IXTOg';
    final accountId = '20973161';

    final sessionId = await getSessionId();

    final url = Uri.https(
      'api.themoviedb.org',
      '/3/account/$accountId',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $apiKey',
          'session_id': sessionId!,
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = User.fromJson(data);
        return user;
      } else {
        print('API request failed with status code: ${response.statusCode}');
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      print('Network error: $e');
      throw Exception('Failed to fetch user data');
    }
  }
}
