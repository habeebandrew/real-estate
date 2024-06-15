import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/global%20Widgets/my_button.dart';

class SignUp extends StatelessWidget {
  static const String ScreenRoute = 'Signup_User';



    const SignUp({super.key});

  // Future<void> _registerUser(BuildContext context) async {
  //   final response =
  //       await http.post(Uri.parse('http://10.0.2.2:8000/api/register'), body:
  //               //  jsonEncode(<String, String>
  //               {
  //     'first_name': "asd", //_firstNameController.text,
  //     'last_name': "ds", // _lastNameController.text,
  //     'email': "hsssabeb@gmail.com", //_emailController.text,
  //     'password': "0000000000", //_passwordController.text,
  //     'password_confirmation': "0000000000" //_confirmPasswordController.text,
  //   }
  //           // ),
  //           );
  //
  //   if (response.statusCode == 200) {
  //     print("successsssssss0");
  //     // If the server returns a 201 CREATED response,
  //     // navigate to the next screen or show a success message
  //     Navigator.of(context).push(_createRoute());
  //   } else {
  //     print("Noooo");
  //     // If the server did not return a 201 CREATED response,
  //     // show an error message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to register. Please try again.'),
  //       ),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 30.h),
                Image.asset(
                  'assets/images/authentication/test1.png', // تأكد من إضافة الصورة في مجلد assets
                  height: 150.h,
                ),
                SizedBox(height: 20.h),
                Text(
                  "Sign up as a user",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: const Color(0xFFBBAB8C),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      
                      borderSide: BorderSide(
                          color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
                    ),
                  ),
                  maxLength: 55,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    } else if (value.length > 55) {
                      return 'First name cannot exceed 55 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
                    ),
                  ),
                  maxLength: 55,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    } else if (value.length > 55) {
                      return 'Last name cannot exceed 55 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10.h),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                MyButton(
                    color: const Color(0xFFBBAB8C),
                    tittle: "Sign up",
                    onPreessed: () {
                      print("object");
                      // _registerUser(context);

                      // if (_formKey.currentState!.validate()) {
                      //   // Validation passed, perform login or further actions
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       duration: Duration(seconds: 2),
                      //       content: Text('Registration ...'),
                      //     ),
                      //   );

                      //   // Send the registration data to the API
                      // }
                    },
                    minWidth: width * 0.5,
                    height: height * 0.07)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>AppRoutes.homeScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
