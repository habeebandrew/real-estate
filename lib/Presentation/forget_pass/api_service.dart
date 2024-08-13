// lib/services/api_service.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Util/api_endpoints.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/animation.dart';
import '../../Util/global Widgets/mySnackBar.dart';
import '../../Util/network_helper.dart';

class ApiService_forgot {


  Future<Map<String, dynamic>> forgotPassword(String email,BuildContext context) async {
    await CacheHelper.putString(value:email,key: 'email_forget');

    final response = await NetworkHelper.post(
      ApiAndEndpoints.forgotPassword,
      headers: {
        'Content-Type': 'application/json'},
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final otp = responseData['otp'];
      print(otp);
      await CacheHelper.putString(value:otp,key: 'opt');
//CacheHelper.getString(key: 'opt'));
      mySnackBar(
        context: context,
        title: 'check your email to verify',
        color: Colors.green
    );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).push(
          MyAnimation.createRoute(AppRoutes.forget_verify),
        );
      });

      print(response.body);
      return jsonDecode(response.body);

    } else {
    mySnackBar(
      context: context,
      title: 'Failed to reset password. Please try again.',
      color: Colors.red
    );
      throw Exception('Failed to reset password');
    }
  }
  Future<void> updatePassword({required BuildContext context,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    String? opt =await CacheHelper.getString(key: 'opt');

    final response = await NetworkHelper.put(
      ApiAndEndpoints.updatePassword,
      headers: {
        'Content-Type': 'application/json',          'Authorization': 'Bearer $opt',
      },
      body: { 'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,},
    );

    if (response.statusCode == 200) {
      mySnackBar(color: Colors.green,
        context: context,
        title: response.body,
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
      });

      print('Password updated successfully');
    } else {
      mySnackBar(color: Colors.red,
        context: context,
        title: response.body,
      );
      // Error
      throw Exception('Failed to update password: ${response.body}');
    }
  }
}
