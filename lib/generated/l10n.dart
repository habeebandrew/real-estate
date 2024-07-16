// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Do you really want to go out?`
  String get go_out {
    return Intl.message(
      'Do you really want to go out?',
      name: 'go_out',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `alert`
  String get alert {
    return Intl.message(
      'alert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `You do not have permission add any thing. Please log in!!`
  String get Please_log_in {
    return Intl.message(
      'You do not have permission add any thing. Please log in!!',
      name: 'Please_log_in',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get Log_In {
    return Intl.message(
      'Log In',
      name: 'Log_In',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get Add {
    return Intl.message(
      'Add',
      name: 'Add',
      desc: '',
      args: [],
    );
  }

  /// `You do not have permission to add areal estate ad. Please subscription as a broker!!`
  String get Please_subscription {
    return Intl.message(
      'You do not have permission to add areal estate ad. Please subscription as a broker!!',
      name: 'Please_subscription',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get Subscription {
    return Intl.message(
      'Subscription',
      name: 'Subscription',
      desc: '',
      args: [],
    );
  }

  /// `Add a real estate ad`
  String get Add_real {
    return Intl.message(
      'Add a real estate ad',
      name: 'Add_real',
      desc: '',
      args: [],
    );
  }

  /// `Add a post`
  String get Add_post {
    return Intl.message(
      'Add a post',
      name: 'Add_post',
      desc: '',
      args: [],
    );
  }

  /// `close`
  String get close {
    return Intl.message(
      'close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Posts`
  String get Posts {
    return Intl.message(
      'Posts',
      name: 'Posts',
      desc: '',
      args: [],
    );
  }

  /// `Favourite`
  String get Favourite {
    return Intl.message(
      'Favourite',
      name: 'Favourite',
      desc: '',
      args: [],
    );
  }

  /// `Properties`
  String get Properties {
    return Intl.message(
      'Properties',
      name: 'Properties',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `most watched`
  String get most_watched {
    return Intl.message(
      'most watched',
      name: 'most_watched',
      desc: '',
      args: [],
    );
  }

  /// `Search real estate`
  String get Search_real {
    return Intl.message(
      'Search real estate',
      name: 'Search_real',
      desc: '',
      args: [],
    );
  }

  /// `on the beach`
  String get on_the_beach {
    return Intl.message(
      'on the beach',
      name: 'on_the_beach',
      desc: '',
      args: [],
    );
  }

  /// `Types of properties >`
  String get Types {
    return Intl.message(
      'Types of properties >',
      name: 'Types',
      desc: '',
      args: [],
    );
  }

  /// `farm`
  String get farm {
    return Intl.message(
      'farm',
      name: 'farm',
      desc: '',
      args: [],
    );
  }

  /// `apartment`
  String get apartment {
    return Intl.message(
      'apartment',
      name: 'apartment',
      desc: '',
      args: [],
    );
  }

  /// `office`
  String get office {
    return Intl.message(
      'office',
      name: 'office',
      desc: '',
      args: [],
    );
  }

  /// `villa`
  String get villa {
    return Intl.message(
      'villa',
      name: 'villa',
      desc: '',
      args: [],
    );
  }

  /// `building`
  String get building {
    return Intl.message(
      'building',
      name: 'building',
      desc: '',
      args: [],
    );
  }

  /// `ok`
  String get ok {
    return Intl.message(
      'ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `language`
  String get language {
    return Intl.message(
      'language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Help Center`
  String get Help_Center {
    return Intl.message(
      'Help Center',
      name: 'Help_Center',
      desc: '',
      args: [],
    );
  }

  /// `Connect with us`
  String get Connect_us {
    return Intl.message(
      'Connect with us',
      name: 'Connect_us',
      desc: '',
      args: [],
    );
  }

  /// `privacy policy`
  String get privacy_policy {
    return Intl.message(
      'privacy policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Account Information`
  String get Account_Information {
    return Intl.message(
      'Account Information',
      name: 'Account_Information',
      desc: '',
      args: [],
    );
  }

  /// `My posts`
  String get My_posts {
    return Intl.message(
      'My posts',
      name: 'My_posts',
      desc: '',
      args: [],
    );
  }

  /// `Invite friends`
  String get Invite_friends {
    return Intl.message(
      'Invite friends',
      name: 'Invite_friends',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `My real estate`
  String get My_estate {
    return Intl.message(
      'My real estate',
      name: 'My_estate',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Forget the password?`
  String get Forget_password {
    return Intl.message(
      'Forget the password?',
      name: 'Forget_password',
      desc: '',
      args: [],
    );
  }

  /// `new member?`
  String get new_member {
    return Intl.message(
      'new member?',
      name: 'new_member',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get Sign_up {
    return Intl.message(
      'Sign up',
      name: 'Sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Log in as guest`
  String get Login_guest {
    return Intl.message(
      'Log in as guest',
      name: 'Login_guest',
      desc: '',
      args: [],
    );
  }

  /// `Sign up as a user`
  String get Signup_user {
    return Intl.message(
      'Sign up as a user',
      name: 'Signup_user',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get User_Name {
    return Intl.message(
      'User Name',
      name: 'User_Name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get Please_password {
    return Intl.message(
      'Please enter your password',
      name: 'Please_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long`
  String get Password_characters_long {
    return Intl.message(
      'Password must be at least 8 characters long',
      name: 'Password_characters_long',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your User name`
  String get Please_name {
    return Intl.message(
      'Please enter your User name',
      name: 'Please_name',
      desc: '',
      args: [],
    );
  }

  /// `User name cannot exceed 55 characters`
  String get User_name_characters {
    return Intl.message(
      'User name cannot exceed 55 characters',
      name: 'User_name_characters',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get Please_email {
    return Intl.message(
      'Please enter your email',
      name: 'Please_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get Please_valid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'Please_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get Confirm_Password {
    return Intl.message(
      'Confirm Password',
      name: 'Confirm_Password',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get Please_confirm_password {
    return Intl.message(
      'Please confirm your password',
      name: 'Please_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get Passwords_match {
    return Intl.message(
      'Passwords do not match',
      name: 'Passwords_match',
      desc: '',
      args: [],
    );
  }

  /// `There are no posts published previously !`
  String get There_are_no_posts {
    return Intl.message(
      'There are no posts published previously !',
      name: 'There_are_no_posts',
      desc: '',
      args: [],
    );
  }

  /// `DELETE`
  String get DELETE {
    return Intl.message(
      'DELETE',
      name: 'DELETE',
      desc: '',
      args: [],
    );
  }

  /// `DELETE the post`
  String get DELETE_post {
    return Intl.message(
      'DELETE the post',
      name: 'DELETE_post',
      desc: '',
      args: [],
    );
  }

  /// `Wanted for`
  String get Wanted_for {
    return Intl.message(
      'Wanted for',
      name: 'Wanted_for',
      desc: '',
      args: [],
    );
  }

  /// ` property in`
  String get property_in {
    return Intl.message(
      ' property in',
      name: 'property_in',
      desc: '',
      args: [],
    );
  }

  /// `Budget:`
  String get Budget {
    return Intl.message(
      'Budget:',
      name: 'Budget',
      desc: '',
      args: [],
    );
  }

  /// `You do not have permission to see the phone number. Please log in and sign up as a broker!!`
  String get Please_loginandsignup_broker {
    return Intl.message(
      'You do not have permission to see the phone number. Please log in and sign up as a broker!!',
      name: 'Please_loginandsignup_broker',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get Contact {
    return Intl.message(
      'Contact',
      name: 'Contact',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get Comments {
    return Intl.message(
      'Comments',
      name: 'Comments',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment...`
  String get Add_comment {
    return Intl.message(
      'Add a comment...',
      name: 'Add_comment',
      desc: '',
      args: [],
    );
  }

  /// `report`
  String get report {
    return Intl.message(
      'report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Report the post`
  String get Report_post {
    return Intl.message(
      'Report the post',
      name: 'Report_post',
      desc: '',
      args: [],
    );
  }

  /// `There is no data`
  String get no_data {
    return Intl.message(
      'There is no data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Newest`
  String get Newest {
    return Intl.message(
      'Newest',
      name: 'Newest',
      desc: '',
      args: [],
    );
  }

  /// `Oldest`
  String get Oldest {
    return Intl.message(
      'Oldest',
      name: 'Oldest',
      desc: '',
      args: [],
    );
  }

  /// `All Cities`
  String get All_Cities {
    return Intl.message(
      'All Cities',
      name: 'All_Cities',
      desc: '',
      args: [],
    );
  }

  /// `Damascus`
  String get Damascus {
    return Intl.message(
      'Damascus',
      name: 'Damascus',
      desc: '',
      args: [],
    );
  }

  /// `Rural Damascus`
  String get Rural_Damascus {
    return Intl.message(
      'Rural Damascus',
      name: 'Rural_Damascus',
      desc: '',
      args: [],
    );
  }

  /// `Aleppo`
  String get Aleppo {
    return Intl.message(
      'Aleppo',
      name: 'Aleppo',
      desc: '',
      args: [],
    );
  }

  /// `Rural Aleppo`
  String get Rural_Aleppo {
    return Intl.message(
      'Rural Aleppo',
      name: 'Rural_Aleppo',
      desc: '',
      args: [],
    );
  }

  /// `Homs`
  String get Homs {
    return Intl.message(
      'Homs',
      name: 'Homs',
      desc: '',
      args: [],
    );
  }

  /// `Rural Homs`
  String get Rural_Homs {
    return Intl.message(
      'Rural Homs',
      name: 'Rural_Homs',
      desc: '',
      args: [],
    );
  }

  /// `Latakia`
  String get Latakia {
    return Intl.message(
      'Latakia',
      name: 'Latakia',
      desc: '',
      args: [],
    );
  }

  /// `Rural Latakia`
  String get Rural_Latakia {
    return Intl.message(
      'Rural Latakia',
      name: 'Rural_Latakia',
      desc: '',
      args: [],
    );
  }

  /// `Tartous`
  String get Tartous {
    return Intl.message(
      'Tartous',
      name: 'Tartous',
      desc: '',
      args: [],
    );
  }

  /// `Rural Tartous`
  String get Rural_Tartous {
    return Intl.message(
      'Rural Tartous',
      name: 'Rural_Tartous',
      desc: '',
      args: [],
    );
  }

  /// `Hama`
  String get Hama {
    return Intl.message(
      'Hama',
      name: 'Hama',
      desc: '',
      args: [],
    );
  }

  /// `Rural Hama`
  String get Rural_Hama {
    return Intl.message(
      'Rural Hama',
      name: 'Rural_Hama',
      desc: '',
      args: [],
    );
  }

  /// `Idlib`
  String get Idlib {
    return Intl.message(
      'Idlib',
      name: 'Idlib',
      desc: '',
      args: [],
    );
  }

  /// `Rural Idlib`
  String get Rural_Idlib {
    return Intl.message(
      'Rural Idlib',
      name: 'Rural_Idlib',
      desc: '',
      args: [],
    );
  }

  /// `Deir ez-Zor`
  String get Dei_ez_Zor {
    return Intl.message(
      'Deir ez-Zor',
      name: 'Dei_ez_Zor',
      desc: '',
      args: [],
    );
  }

  /// `Rural Deir ez-Zor`
  String get Rural_Deir_ez_Zor {
    return Intl.message(
      'Rural Deir ez-Zor',
      name: 'Rural_Deir_ez_Zor',
      desc: '',
      args: [],
    );
  }

  /// `Raqqa`
  String get Raqqa {
    return Intl.message(
      'Raqqa',
      name: 'Raqqa',
      desc: '',
      args: [],
    );
  }

  /// `Rural Raqqa`
  String get Rural_Raqqa {
    return Intl.message(
      'Rural Raqqa',
      name: 'Rural_Raqqa',
      desc: '',
      args: [],
    );
  }

  /// `Al-Hasakah`
  String get Al_Hasakah {
    return Intl.message(
      'Al-Hasakah',
      name: 'Al_Hasakah',
      desc: '',
      args: [],
    );
  }

  /// `Rural Al-Hasakah`
  String get Rural_Al_Hasakah {
    return Intl.message(
      'Rural Al-Hasakah',
      name: 'Rural_Al_Hasakah',
      desc: '',
      args: [],
    );
  }

  /// `Daraa`
  String get Daraa {
    return Intl.message(
      'Daraa',
      name: 'Daraa',
      desc: '',
      args: [],
    );
  }

  /// `Rural Daraa`
  String get Rural_Daraa {
    return Intl.message(
      'Rural Daraa',
      name: 'Rural_Daraa',
      desc: '',
      args: [],
    );
  }

  /// `As-Suwayda`
  String get As_Suwayda {
    return Intl.message(
      'As-Suwayda',
      name: 'As_Suwayda',
      desc: '',
      args: [],
    );
  }

  /// `Rural As-Suwayda`
  String get Rural_As_Suwayda {
    return Intl.message(
      'Rural As-Suwayda',
      name: 'Rural_As_Suwayda',
      desc: '',
      args: [],
    );
  }

  /// `Quneitra`
  String get Quneitra {
    return Intl.message(
      'Quneitra',
      name: 'Quneitra',
      desc: '',
      args: [],
    );
  }

  /// `Rural Quneitra`
  String get Rural_Quneitra {
    return Intl.message(
      'Rural Quneitra',
      name: 'Rural_Quneitra',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get All {
    return Intl.message(
      'All',
      name: 'All',
      desc: '',
      args: [],
    );
  }

  /// `buy`
  String get buy {
    return Intl.message(
      'buy',
      name: 'buy',
      desc: '',
      args: [],
    );
  }

  /// `rental`
  String get rental {
    return Intl.message(
      'rental',
      name: 'rental',
      desc: '',
      args: [],
    );
  }

  /// `Edit phone number`
  String get Edit_phone_number {
    return Intl.message(
      'Edit phone number',
      name: 'Edit_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Enter the new phone number`
  String get Enter_new_number {
    return Intl.message(
      'Enter the new phone number',
      name: 'Enter_new_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a phone number`
  String get Please_number {
    return Intl.message(
      'Please enter a phone number',
      name: 'Please_number',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must be between 10 and 13 digits`
  String get Phone_digits {
    return Intl.message(
      'Phone number must be between 10 and 13 digits',
      name: 'Phone_digits',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get Edit {
    return Intl.message(
      'Edit',
      name: 'Edit',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile Picture`
  String get Edit_Picture {
    return Intl.message(
      'Edit Profile Picture',
      name: 'Edit_Picture',
      desc: '',
      args: [],
    );
  }

  /// `Select a new profile picture`
  String get Select_picture {
    return Intl.message(
      'Select a new profile picture',
      name: 'Select_picture',
      desc: '',
      args: [],
    );
  }

  /// `Choose from Gallery`
  String get Choose_Gallery {
    return Intl.message(
      'Choose from Gallery',
      name: 'Choose_Gallery',
      desc: '',
      args: [],
    );
  }

  /// `Account informations`
  String get Account_informations {
    return Intl.message(
      'Account informations',
      name: 'Account_informations',
      desc: '',
      args: [],
    );
  }

  /// `No phone number added`
  String get No_phone {
    return Intl.message(
      'No phone number added',
      name: 'No_phone',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
