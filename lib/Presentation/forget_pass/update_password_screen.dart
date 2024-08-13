import 'package:flutter/material.dart';
import '../../Util/cache_helper.dart';
import 'api_service.dart'; // تأكد من استيراد ملف api_service.dart

class UpdatePasswordScreen extends StatefulWidget {
  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  //email_forget
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _apiService = ApiService_forgot(); // استبدل بالـ base URL الخاص بك
  String? email =  CacheHelper.getString(key: 'email_forget');

  void _updatePassword() async {
    try {
      await _apiService.updatePassword(
        password: _passwordController.text,
        passwordConfirmation: _passwordConfirmationController.text, context: context, email: '$email',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
"$email"            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'New Password'),
              obscureText: true,
            ),
            TextField(
              controller: _passwordConfirmationController,
              decoration: InputDecoration(labelText: 'Confirm New Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePassword,
              child: Text('Update Password'),
            ),
          ],
        ),
      ),
    );
  }
}
