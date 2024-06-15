import 'package:flutter/material.dart';
import 'package:pro_2/authentication/User/Signin_User.dart';

class Signin_Broker extends StatefulWidget {
  static const String ScreenRoute = 'Signin_Broker';

  const Signin_Broker({super.key});

  @override
  State<Signin_Broker> createState() => _Signin_BrokerState();
}

class _Signin_BrokerState extends State<Signin_Broker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.person_add),
                            title: Text('Sign Up'),
                            onTap: () {
                              Navigator.pop(context); // إغلاق القائمة المنبثقة
                              Navigator.pushNamed(
                                  context,
                                  Signin_Broker
                                      .ScreenRoute); // انتقال إلى صفحة التسجيل
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.login),
                            title: Text('Sign In'),
                            onTap: () {
                              Navigator.pop(context); // إغلاق القائمة المنبثقة
                              Navigator.pushNamed(
                                  context,
                                  SigninUser
                                      .ScreenRoute); // انتقال إلى صفحة تسجيل الدخول
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text('Open Sign Up / Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
