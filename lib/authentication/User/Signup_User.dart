import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Widgets/my_button.dart';

class Signup_User extends StatefulWidget {
  static const String ScreenRoute = 'Signup_User';

  const Signup_User({super.key});

  @override
  State<Signup_User> createState() => _Signup_UserState();
}

class _Signup_UserState extends State<Signup_User> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
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
                      color: Color(0xFFBBAB8C),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
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
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
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
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
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
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
                    ),

                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                MyButton(
                    color: Color(0xFFBBAB8C),
                    tittle: "Sign up",
                    onPreessed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration Successful')),
                        );
                      }
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
}
