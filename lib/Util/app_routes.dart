
import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Ad%20Propert%20Screen/ad_property_screen.dart';
import 'package:pro_2/Presentation/Advanced%20Search%20Screen/advanced_search_screen.dart';
import 'package:pro_2/Presentation/Auctions/Add_Auction_screen.dart';
import 'package:pro_2/Presentation/Auctions/auction_detail_screen.dart';
import 'package:pro_2/Presentation/Drawer%20Screen/drawer_screen.dart';
import 'package:pro_2/Presentation/Favourite%20Screen/favourite_screen.dart';
import 'package:pro_2/Presentation/Home%20Screen/home_screen.dart';
import 'package:pro_2/Presentation/LogIn%20Screen/LogIn_screen.dart';
import 'package:pro_2/Presentation/Main%20Screen/main_screen.dart';
import 'package:pro_2/Presentation/My_Posts/My_Posts.dart';
import 'package:pro_2/Presentation/Onboarding%20Screens/onboarding1.dart';
import 'package:pro_2/Presentation/Posts%20Screen/posts_screen.dart';
import 'package:pro_2/Presentation/Properties%20Screen/properties_screen.dart';
import 'package:pro_2/Presentation/Property%20Details%20Screen/property_details_screen.dart';
import 'package:pro_2/Presentation/SignUp%20Screen/Signup_screen.dart';
import 'package:pro_2/Presentation/SignUp%20Screen/email_verification_screen.dart';
import 'package:pro_2/Presentation/sharingtime/property_sharing_screen.dart';
import '../Presentation/AccountInfoPage/AccountInfoPage.dart';
import '../Presentation/Auctions/auction_list_screen.dart';
import '../Presentation/ContactWithUs/ContactUsPage.dart';
import '../Presentation/Add Post Screen/add_post_screen.dart';
import '../Presentation/Confirm Add Post/confirm_add_post.dart';
import '../Presentation/SplashScreen/splash_screen.dart';
import '../Presentation/Subscription/subscription_screen.dart';
import '../Presentation/forget_pass/forget_verify.dart';
import '../Presentation/forget_pass/forgot_password_screen.dart';
import '../Presentation/forget_pass/update_password_screen.dart';
import '../Presentation/sharingtime/AddProperty_sharing_Screen.dart';
import '../Presentation/sharingtime/property_sharing_detail_screen.dart';
import '../tests/360pic.dart';


class NamedRoutes
{
  static const property_sharing_DetailScreen='property_sharing_detail_screen';


  static const homeScreen='HomeScreen';
  static const onBoardingScreen='onboarding1';
  static const passwordSetupScreen='passwordSetupScreen';
  static const signUpScreen='Signup';
  static const logInScreen='Login';
  static const splashscreen='splash_screen';
  static const postsScreen='postsScreen';
  static const favouriteScreen='favouriteScreen';
  //لازم نضيف تبع اضافة طلب لليوزر
  static const adPropertyScreen='adPropertyScreen';
  static const propertiesScreen='propertiesScreen';
  static const mainScreen='mainScreen';
  static const drawerScreen='drawerScreen';
  static const Contactwithus='ContactUsPage';
  static const addpost='add_post_screen';
  static const subscription='Subscription';
  static const My_Posts='My_Posts';
  static const accountInfoPage ='AccountInfoPage';
  static const propertyDetails ='propertyDetails';
  static const pic360='360pic';

  static const forgotPasswordScreen='ForgotPasswordScreen';
  static const forget_verify='forget_verify';
  static const UpdatePasswordScreen='update_password_screen';
  static const auction_screen='auction_list_screen';
  static const addauctions='Add_Auction_screens';
  static const add_sharing_Screen='AddProperty_sharing_Screen';


  static const showsharing='property_sharing_screen';

  static const auctionDetailScreen='auction_detail_screen';

}

class AppRoutes
{
  static UpdatePasswordScreen  updatePasswordScreen=UpdatePasswordScreen();
  static Property_sharing_DetailScreen  property_sharing_DetailScreen=Property_sharing_DetailScreen(propertyId: 0,);

  static Add_sharing_Screen  add_sharing_Screen=Add_sharing_Screen();

  static show_sharing  showsharing=show_sharing();

  static AuctionDetailScreen  auctionDetailScreen=AuctionDetailScreen(auctionId: 0,);

  static const  homeScreen=HomeScreen();
  static AuctionListScreen  auction_screen=AuctionListScreen();

  static const  onBoardingScreen=Onboarding();
  static EmailVerificationScreen  emailVerificationScreen= EmailVerificationScreen();
  static const  signUpScreen= SignUp();
  static const  logInScreen=LogInScreen();
  static const  Splashscreen=splashscreen();
  static PostsScreen  postsScreen=PostsScreen();
  static const favouriteScreen=FavouriteScreen();
  //لازم نضيف تبع اضافة طلب لليوزر
  static const adPropertyScreen=AdPropertyScreen();
  static const propertiesScreen=PropertiesScreen();
  static MainScreen mainScreen=MainScreen();
  static const drawerScreen=DrawerScreen();
   static ContactUsPage contactwithus=ContactUsPage();
  static const addPost=AddPostScreen();
  // static const confirmAddPost=ConfirmAddPost(selectedGovernorate: '', budget: null,status: ,selectedArea: ,phone: ,description: ,key: ,);
  static SubscriptionScreen subscription=SubscriptionScreen();
  static My_Posts My_posts=My_Posts();
  static AccountInfoPage accountInfoPage =AccountInfoPage();
  static PropertyDetailsScreen propertyDetails =PropertyDetailsScreen(propertyId: 0,favourite: false,);
  static s_3dpic  pic360=s_3dpic(propertyId: null!,);

  static ForgotPasswordScreen  forgotPasswordScreen=ForgotPasswordScreen();

  static Forget_verify  forget_verify=Forget_verify();
  
  static AddAuctions addauctions= AddAuctions();

  static const AdvancedSearch = AdvancedSearchScreen();




  static Map <String,Widget Function(BuildContext context)>routes=
  {
    NamedRoutes.UpdatePasswordScreen:(context)=>AppRoutes.updatePasswordScreen,
    NamedRoutes.auctionDetailScreen:(context)=>AppRoutes.auctionDetailScreen,

    NamedRoutes.forget_verify:(context)=>AppRoutes.forget_verify,
    NamedRoutes.add_sharing_Screen:(context)=>AppRoutes.add_sharing_Screen,


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
    NamedRoutes.drawerScreen:(context)=>AppRoutes.drawerScreen,
    NamedRoutes.Contactwithus:(context)=>AppRoutes.contactwithus,
    NamedRoutes.addpost:(context)=>AppRoutes.addPost,
    NamedRoutes.subscription:(context)=>AppRoutes.subscription,
    NamedRoutes.My_Posts:(context)=>AppRoutes.My_posts,
    NamedRoutes.accountInfoPage :(context)=>AppRoutes.accountInfoPage ,
    NamedRoutes.propertyDetails :(context)=>AppRoutes.propertyDetails ,
    NamedRoutes.pic360 :(context)=>AppRoutes.pic360 ,
    NamedRoutes.forgotPasswordScreen :(context)=>AppRoutes.forgotPasswordScreen ,
    NamedRoutes.addauctions :(context)=>AppRoutes.addauctions ,
    NamedRoutes.auction_screen :(context)=>AppRoutes.auction_screen ,
    NamedRoutes.property_sharing_DetailScreen :(context)=>AppRoutes.property_sharing_DetailScreen ,


    NamedRoutes.showsharing :(context)=>AppRoutes.showsharing ,


  };
}