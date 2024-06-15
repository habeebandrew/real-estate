import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pro_2/authentication/Broker/Signin_Broker.dart';
import 'package:pro_2/authentication/Broker/Signup_Broker.dart';
import 'package:pro_2/authentication/User/Signup_User.dart';

import '../../Widgets/my_button.dart';

class SigninUser extends StatefulWidget {
  static const String ScreenRoute = 'Signin_User';

  const SigninUser({super.key});

  @override
  State<SigninUser> createState() => _SigninUserState();
}

class _SigninUserState extends State<SigninUser> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _NameController = TextEditingController();
    final _passwordController = TextEditingController();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            Container(
              height: height * 0.35,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), // تدوير الزوايا
                  image: DecorationImage(
                    image: AssetImage('assets/images/authentication/test1.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: height * 0.05,
                // ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _NameController,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود الافتراضي
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFBBAB8C)), // لون الحدود عند التركيز
                          ),

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          } else if (value.length > 55) {
                            return 'Last name cannot exceed 55 characters';
                          }
                          return null;
                        },
                      ),
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
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // اضف الكود هنا لإعادة تعيين كلمة المرور
                    },
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.04,
                        decoration:
                            TextDecoration.underline, // إضافة تسطير تحت النص
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                MyButton(
                    color: Color(0xFFBBAB8C),
                    tittle: 'Sign in',
                    onPreessed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration Successful')),
                        );
                      }
                      Navigator.pushNamed(context, Signin_Broker.ScreenRoute);
                    },
                    minWidth: width * 0.5,
                    height: height * 0.07),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("   Are you new member?"),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: height * 0.2,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.person_add),
                                    title: Text('Sign Up As User'),
                                    onTap: () {
                                      Navigator.pop(
                                          context); // إغلاق القائمة المنبثقة
                                      Navigator.of(context)
                                          .push(_createRoute());

                                      // Navigator.pushNamed(
                                      //     context,
                                      //     Signup_User
                                      //         .ScreenRoute); // انتقال إلى صفحة التسجيل
                                    },
                                  ),
                                  Divider(),
                                  ListTile(
                                    leading: Icon(Icons.no_accounts_outlined),
                                    title: Text('Sign Up As Broker'),
                                    onTap: () {
                                      Navigator.pop(
                                          context); // إغلاق القائمة المنبثقة
                                      Navigator.pushNamed(
                                          context,
                                          Signup_Broker
                                              .ScreenRoute); // انتقال إلى صفحة تسجيل الدخول
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.045,
                          fontWeight:
                              FontWeight.bold, // إضافة خط ثقيل لتسمية نمط الخط
                          decoration:
                              TextDecoration.underline, // إضافة خط تحت النص
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Signup_User(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: Duration(seconds: 2));
}
