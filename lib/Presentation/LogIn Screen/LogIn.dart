import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Home%20Screen/HomeScreen.dart';
import 'package:pro_2/Presentation/SignUp%20Screen/Signup.dart';
import 'package:pro_2/Util/app_routes.dart';

import '../../Util/global Widgets/my_button.dart';

class LogInScreen extends StatelessWidget {


   const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                  color: const Color(0xFFFEF7E4),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: usernameController,
                              decoration: const InputDecoration(
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
                          const SizedBox(height: 20.0),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextFormField(
                              controller: passwordController,
                              decoration: const InputDecoration(
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
                          const SizedBox(height: 20.0),
                          MyButton(
                              color: const Color(0xFFBBAB8C),
                              tittle: "Sign in",
                              onPreessed: () {
                                print("object");
                                if (formKey.currentState!.validate()) {
                                  // Validation passed, perform login or further actions
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Text('Logging in...'),
                                    ),
                                  );

                                  // Delay for 2 seconds and then navigate to the next screen
                                  Future.delayed(const Duration(seconds: 2), () {
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
                              child: const Text(
                                "Forget the password?",
                                style: TextStyle(color: Color(0xFFBBAB8C)),
                              )),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Row(
                            children: [
                              const Text(
                                "new member?",
                                style: TextStyle(
                                    color: Color(0xFFBBAB8C),
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              TextButton(
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SizedBox(
                                          height: height * 0.2,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: const Icon(Icons.person_add),
                                                title: const Text('Sign Up'),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  Navigator.of(context)
                                                      .push(_createRoute());
                                                },
                                              ),
                                              const Divider(),
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.no_accounts_outlined),
                                                title: const Text('Log in as guest'),
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
      pageBuilder: (context, animation, secondaryAnimation) => AppRoutes.homeScreen,
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
      transitionDuration: const Duration(seconds: 2));
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>AppRoutes.signUpScreen,
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
      transitionDuration: const Duration(seconds: 2));
}
