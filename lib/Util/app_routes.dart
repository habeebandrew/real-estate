
import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Ad%20Propert%20Screen/ad_property_screen.dart';
import 'package:pro_2/Presentation/Favourite%20Screen/favourite_screen.dart';
import 'package:pro_2/Presentation/Home%20Screen/home_screen.dart';
import 'package:pro_2/Presentation/LogIn%20Screen/LogIn_screen.dart';
import 'package:pro_2/Presentation/Main%20Screen/main_screen.dart';
import 'package:pro_2/Presentation/Onboarding_screens/onboarding1.dart';
import 'package:pro_2/Presentation/Posts%20Screen/posts_screen.dart';
import 'package:pro_2/Presentation/Properties%20Screen/properties_screen.dart';
import 'package:pro_2/Presentation/SignUp%20Screen/Signup_screen.dart';
import '../Presentation/SplashScreen/splash_screen.dart';


class NamedRoutes
{
  static const homeScreen='HomeScreen';
  static const onBoardingScreen='onboarding1';
  static const signUpScreen='Signup';
  static const logInScreen='Login';
  static const splashscreen='splash_screen';
  static const postsScreen='postsScreen';
  static const favouriteScreen='favouriteScreen';
  //لازم نضيف تبع اضافة طلب لليوزر
  static const adPropertyScreen='adPropertyScreen';
  static const propertiesScreen='propertiesScreen';
  static const mainScreen='mainScreen';

// static const test1_json='doneTaskScreen';


}

class AppRoutes
{
  static const  homeScreen=HomeScreen();
  static const  onBoardingScreen=Onboarding();
  static const  signUpScreen= SignUp();
  static const  logInScreen=LogInScreen();
  static const  Splashscreen=splashscreen();
  static const postsScreen=PostsScreen();
  static const favouriteScreen=FavouriteScreen();
  //لازم نضيف تبع اضافة طلب لليوزر
  static const adPropertyScreen=AdPropertyScreen();
  static const propertiesScreen=PropertiesScreen();
  static const mainScreen=MainScreen();

  // static const  test1_json=theList();


  static Map <String,Widget Function(BuildContext context)>routes=
  {
    NamedRoutes.homeScreen:(context)=>AppRoutes.homeScreen,
    NamedRoutes.onBoardingScreen:(context)=>AppRoutes.onBoardingScreen,
    NamedRoutes.signUpScreen:(context)=>AppRoutes.signUpScreen,
    NamedRoutes.logInScreen:(context)=>AppRoutes.logInScreen,
    NamedRoutes.splashscreen:(context)=>AppRoutes.Splashscreen,
    NamedRoutes.postsScreen:(context)=>AppRoutes.postsScreen,
    NamedRoutes.favouriteScreen:(context)=>AppRoutes.favouriteScreen,
    NamedRoutes.adPropertyScreen:(context)=>AppRoutes.adPropertyScreen,
    NamedRoutes.propertiesScreen:(context)=>AppRoutes.propertiesScreen,
    NamedRoutes.mainScreen:(context)=>AppRoutes.mainScreen,

    // NamedRoutes.test1_json:(context)=>AppRoutes.test1_json,

  };
}