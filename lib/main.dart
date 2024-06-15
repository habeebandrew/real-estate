import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/authentication/Broker/Signup_Broker.dart';
import 'package:pro_2/authentication/Broker/signin_Broker.dart';
import 'package:pro_2/authentication/User/Signin_User.dart';
import 'package:pro_2/authentication/User/Signup_User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Onboarding_screens/onboarding1.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool("showHome") ?? false;
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812), // حجم التصميم الأصلي
      minTextAdapt: true,

      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Real Estate',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFBBAB8C)),
            useMaterial3: true,
          ),
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          // home: showHome ? HomePage() : Onboarding(),
          // home: Onboarding(),
          initialRoute: SigninUser.ScreenRoute,
          routes: {
            Onboarding.ScreenRoute: (context) => Onboarding(),
            //*****Broker*****/
            Signup_Broker.ScreenRoute: (context) => Signup_Broker(),
            Signin_Broker.ScreenRoute: (context) => Signin_Broker(),
            //*****User*****/
            SigninUser.ScreenRoute: (context) => SigninUser(),
            Signup_User.ScreenRoute: (context) => Signup_User(),
          }),
    );
  }
}
/* OUr colors
DED0B6
F9EED0
FEF7E4
*/
