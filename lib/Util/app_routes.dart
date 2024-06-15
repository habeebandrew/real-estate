
import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Home%20Screen/HomeScreen.dart';
import 'package:pro_2/Presentation/LogIn%20Screen/LogIn.dart';
import 'package:pro_2/Presentation/Onboarding_screens/onboarding1.dart';
import 'package:pro_2/Presentation/SignUp%20Screen/Signup.dart';

class NamedRoutes
{
  static const homeScreen='HomeScreen';
  static const onBoardingScreen='newTaskScreen';
  static const signUpScreen='addTaskScreen';
  static const logInScreen='doneTaskScreen';


}

class AppRoutes
{
  static const  homeScreen=HomeScreen();
  static const  onBoardingScreen=Onboarding();
  static const  signUpScreen= SignUp();
  static const  logInScreen=LogInScreen();


  static Map <String,Widget Function(BuildContext context)>routes=
  {
    NamedRoutes.homeScreen:(context)=>AppRoutes.homeScreen,
    NamedRoutes.onBoardingScreen:(context)=>AppRoutes.onBoardingScreen,
    NamedRoutes.signUpScreen:(context)=>AppRoutes.signUpScreen,
    NamedRoutes.logInScreen:(context)=>AppRoutes.logInScreen,

  };
}