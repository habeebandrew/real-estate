import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:pro_2/Data/user_model.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/network_helper.dart';

import '../../Util/global Widgets/mySnackBar.dart';
class AuthService {
  static Future<String?> signUp({
    required String user_name,
    required String email,
    required String password,
    required String passwordConfirm,
    required BuildContext context,
  }) async {
    try {
      final response = await NetworkHelper.post(
        ApiAndEndpoints.signUp,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',

        },
        body: {
          "user_name": user_name,
          "email": email,
          "passwoord": password,
          "passwoord_confirmation": passwordConfirm,
        },
      );

      if (response.statusCode == 200) {
        mySnackBar(
          context: context,
          title:response.body , // عرض الرسالة الواردة من الاستجابة
        );
        // تأكد من أنك تتعامل مع الاستجابة بشكل صحيح هنا
        return response.body; // إرجاع نص الاستجابة
      } else {
        final responseData = jsonDecode(response.body);
        final message = responseData['message'];

        mySnackBar(
          context: context,
          title:message , // عرض الرسالة الواردة من الاستجابة
        );
        print(response.body);
        print('Failed to register. HTTP status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error occurred: $e');
      return null;
    }
  }
  static Future<User?> login({
    required String email,
    required String password,
  }) async {
    var response = await NetworkHelper.post(
      ApiAndEndpoints.logIn,
      headers: {
        'Content-Type': 'application/json'
      },
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      try {
        var user = userFromJson(response.body);
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

  static Future<bool> logout(String token) async {
    var response = await NetworkHelper.post(
      ApiAndEndpoints.logout,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to log out. HTTP status: ${response.statusCode}');
      return false;
    }
  }
}