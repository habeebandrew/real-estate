
import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Home%20Screen/HomeScreen.dart';
import 'package:pro_2/Presentation/LogIn%20Screen/LogIn.dart';
import 'package:pro_2/Presentation/Onboarding_screens/onboarding1.dart';
import 'package:pro_2/Presentation/SignUp%20Screen/Signup.dart';
import 'package:pro_2/test/Test1ForJson.dart';


import '../test/Test1ForJson.dart';

class NamedRoutes
{
  static const homeScreen='HomeScreen';
  static const onBoardingScreen='onboarding1';
  static const signUpScreen='Signup';
  static const logInScreen='Login';
  // static const test1_json='doneTaskScreen';


}

class AppRoutes
{
  static const  homeScreen=HomeScreen();
  static const  onBoardingScreen=Onboarding();
  static const  signUpScreen= SignUp();
  static const  logInScreen=LogInScreen();
  // static const  test1_json=theList();


  static Map <String,Widget Function(BuildContext context)>routes=
  {
    NamedRoutes.homeScreen:(context)=>AppRoutes.homeScreen,
    NamedRoutes.onBoardingScreen:(context)=>AppRoutes.onBoardingScreen,
    NamedRoutes.signUpScreen:(context)=>AppRoutes.signUpScreen,
    NamedRoutes.logInScreen:(context)=>AppRoutes.logInScreen,
    // NamedRoutes.test1_json:(context)=>AppRoutes.test1_json,

  };
}