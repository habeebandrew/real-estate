import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/forget_pass/api_service.dart';

import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/mySnackBar.dart';
import '../../tests/ApiService.dart'; // تأكد من استخدام المسار الصحيح للملف

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final ApiService_forgot _apiService = ApiService_forgot();
  bool _isLoading = false;
  String? _errorMessage;

  void _forgotPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final email = _emailController.text.trim();
      final response = await _apiService.forgotPassword(email,context);



      // Clear the text field
      _emailController.clear();
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to reset password. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                errorText: _errorMessage,
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed:() {_forgotPassword();
                },
              child: Text('Send Reset Link'),
            ),

          ],
        ),
      ),
    );
  }
}