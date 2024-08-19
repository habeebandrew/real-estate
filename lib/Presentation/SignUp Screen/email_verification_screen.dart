//refactor with cubit*****
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';

import 'package:http/http.dart' as http;
import 'package:pro_2/Util/network_helper.dart';
import 'dart:convert';

import '../../Util/api_endpoints.dart';
import '../../Util/global Widgets/animation.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter the 6-digit code sent to your email:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            PinCodeTextField(
              appContext: context,
              length: 6,
              controller: _codeController,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 40,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.grey.shade200,
                selectedFillColor: Colors.grey.shade300,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey,
                selectedColor: Colors.blueAccent,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              onCompleted: (value) {
                // _verifyCode(value);
                sendCode(_codeController);
              },
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendCode(_codeController);
                // _verifyCode(_codeController.text);
              },
              child: const Text('Verify'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // TextButton(
            //   onPressed: () {
            //     // إعادة إرسال الرمز
            //     print('Resend code');
            //   },
            //   child: const Text(
            //     'Resend Code',
            //     style: TextStyle(decoration: TextDecoration.underline),
            //   ),
            // ),
            Spacer(),
            Row(
              children: [
                const Text('Already a member?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MyAnimation.createRoute(AppRoutes.logInScreen));
                    // تسجيل الدخول بدلاً من ذلك
                    print('Sign in instead');
                  },
                  child: const Text(
                    'Sign in instead',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendCode(TextEditingController codeController) async {
    // URL الخاص بالـ API الذي ستقوم بإرسال الطلب إليه

    // الحصول على القيمة المحتملة من التخزين المؤقت
    String? user_name_verify =
        await CacheHelper.getString(key: 'user_name_verify');

    // التحقق مما إذا كانت القيمة غير موجودة وتعيين قيمة افتراضية إذا لزم الأمر
    if (user_name_verify == null) {
      print('Error: user_name_verify is null');
      return;
    }
    // محاولة تحويل النص إلى عدد صحيح
    int? codeAsInt;
    try {
      codeAsInt = int.parse(codeController.text);
    } catch (e) {
      print('Error: The code is not a valid integer');
      return;
    }
    print(codeAsInt);
    print("user_name_verify" + user_name_verify);
    print("codeController" + codeController.text);

    try {
      // إرسال طلب POST إلى الـ API
      final response = await NetworkHelper.post(
        ApiAndEndpoints.verify,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: {
          'user_name': "$user_name_verify",
          'code': "${codeAsInt.toString()}",
        },
      );

      // التحقق من استجابة الـ API
      if (response.statusCode == 200) {
        mySnackBar(
          color: Colors.green,
          context: context,
          title: "verified",
        );
        print(response.body);
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // تحقق مما إذا كانت الرسالة هي الرسالة المتوقعة
        if (responseData.containsKey("user")) {
          //الربط مع الموديل
          mySnackBar(
            color: Colors.green,
            context: context,
            title: 'verify successful',
          );
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context)
                .push(MyAnimation.createRoute(AppRoutes.logInScreen));
          });
        } else if (responseData.isNotEmpty &&
            responseData[0] == "you have to enter correct code ...") {
          mySnackBar(
            color: Colors.green,
            context: context,
            title: responseData[0],
          );
          print("النجاح: تم إدخال الكود بشكل صحيح.");
        } else {
          print("الرسالة الواردة: ${responseData}");
        }
      } else {
        print('خطأ: ${response.statusCode}');
      }
    } catch (e) {
      print('استثناء: $e');
    }
  }

  void _verifyCode(String code) {
    if (code.length == 6) {
      // تنفيذ منطق التحقق هنا
      print('Code entered: $code');
      // على سبيل المثال، يمكن التحقق من صحة الرمز والانتقال إلى شاشة أخرى
      //if correct*****************
      mySnackBar(
        context: context,
        title: 'تم تأكيد الرمز بنجاح',
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context)
            .push(MyAnimation.createRoute(AppRoutes.homeScreen));
      });
    } else {
      // عرض رسالة خطأ إذا كان الرمز ليس مكونًا من 6 أرقام
      print('Please enter a 6-digit code.');
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
