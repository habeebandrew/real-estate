import 'dart:convert';
import 'package:pro_2/Data/user_model.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/network_helper.dart';
class AuthService {
  static Future<User?> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    var response = await NetworkHelper.post(
      ApiAndEndpoints.signUp,
      headers: {
        'Content-Type': 'application/json'
      },
      body: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "passwoord": password,
        "passwoord_confirmation": passwordConfirm
      },
    );

    if (response.statusCode == 200) {
      try {
        var user = userFromJson(response.body);
        print(user);
        return user;
      } catch (e) {
        print('Failed to parse JSON: $e');
        return null;
      }
    }

    else {
      print('Failed to register. HTTP status: ${response.statusCode}');
      return null;
    }
  }
}