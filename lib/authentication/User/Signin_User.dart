import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pro_2/HomePage.dart';
import 'package:pro_2/authentication/User/Signup_User.dart';

import '../../Widgets/my_button.dart';

class SignInScreen extends StatelessWidget {
  static const String ScreenRoute = 'Signin_User';

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Image.asset(
              'assets/images/authentication/test1.png', // تأكد من إضافة الصورة في مجلد assets
              height: height * 0.4,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: Color(0xFFFEF7E4),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _usernameController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
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
                          ),
                          SizedBox(height: 20.0),
                          MyButton(
                              color: Color(0xFFBBAB8C),
                              tittle: "Sign in",
                              onPreessed: () {
                                print("object");
                                if (_formKey.currentState!.validate()) {
                                  // Validation passed, perform login or further actions
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text('Logging in...'),
                                    ),
                                  );

                                  // Delay for 2 seconds and then navigate to the next screen
                                  Future.delayed(Duration(seconds: 2), () {
                                    Navigator.of(context).push(_createRoute());
                                  });
                                }
                              },
                              minWidth: width * 0.5,
                              height: height * 0.07),
                          TextButton(
                              onPressed: () {
                                print("object");
                                //Not now
                              },
                              child: Text(
                                "Forget the password?",
                                style: TextStyle(color: Color(0xFFBBAB8C)),
                              )),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              Text(
                                "new member?",
                                style: TextStyle(
                                    color: Color(0xFFBBAB8C),
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              TextButton(
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
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
                                                title: Text('Sign Up'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.of(context)
                                                      .push(_createRoute());
                                                },
                                              ),
                                              Divider(),
                                              ListTile(
                                                leading: Icon(
                                                    Icons.no_accounts_outlined),
                                                title: Text('Log in as guest'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.of(context)
                                                      .push(_createRoute_1());
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      }); /* */
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//***for animarion
Route _createRoute_1() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
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
