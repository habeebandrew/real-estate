// ignore_for_file: unused_element, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_cubit.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/animation.dart';

import '../../../Util/cache_helper.dart';


Widget myDrawerButton({
  required String label,
  required IconData icon,
  required void Function()? onPress,
}) => InkWell(
  onTap: onPress,
  child: Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
    child: Row(
      children: [
        Icon(
          icon,
          size: 22.sp,
          color: Constants.mainColor,
        ),
        SizedBox(width: 12.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
          size: 16.sp,
          color:Constants.mainColor,
        ),
      ],
    ),
  ),
);

//هون حسب مين مسجل دحول بيطلعو الخيارات
Widget build_for_guest(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        myDrawerButton(label: 'language', icon: Icons.language, onPress: () {
          _showLanguageDialog(context);
        }),
        SizedBox(
          height: 5,
        ),
        // myDrawerButton(
        //     label: 'Invite friends', icon: Icons.mail, onPress:() => _shareInvite(context),
        // ),
        // SizedBox(
        //   height: 5,
        // ),
        myDrawerButton(
            label: 'Help Center', icon: Icons.help_outline, onPress: () {}),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
            label: 'Connect with us', icon: Icons.phone, onPress: () {Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.contactwithus));}),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
            label: 'privacy policy', icon: Icons.person, onPress: () {}),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
          label: 'Login',
          icon: Icons.login,
          onPress: () {
            Navigator.of(context)
                .push(MyAnimation.createRoute(AppRoutes.logInScreen));
          },
        ),
      ],
    ),
  );
}

Widget build_for_user(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      children: [
        myDrawerButton(
            label: 'Account Information', icon: Icons.person, onPress: () async {
              String token;
        token =(await CacheHelper.getString(key: 'token'))!;print(token);}),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
          label: 'language',
          icon: Icons.language,
          onPress: () {},
        ),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
          label: 'My posts',
          icon: Icons.article,
          onPress: () {},
        ),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
          label: 'Invite friends',
          icon: Icons.mail,
          onPress: () {},
        ),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
          label: 'Help Center',
          icon: Icons.help_outline,
          onPress: () {},
        ),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
          label: 'Connect with us',
          icon: Icons.phone,
          onPress: () {},
        ),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
          label: 'privacy policy',
          icon: Icons.privacy_tip,
          onPress: () {},
        ),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
          label: 'Logout',
          icon: Icons.logout,
          onPress: () {
            BlocProvider.of<AuthCubit>(context).logOut(context);
          },
        ),
      ],
    ),
  );
}

Widget build_for_Broker(BuildContext context) {
  return Column(
    children: [
      myDrawerButton(
          label: 'Account Information', icon: Icons.person, onPress: () {}),
      SizedBox(
        height: 5,
      ),
      myDrawerButton(
        label: 'language',
        icon: Icons.language,
        onPress: () {},
      ),
      SizedBox(
        height: 5,
      ),
      myDrawerButton(
        label: 'My real estate',
        icon: Icons.home,
        onPress: () {},
      ),
      SizedBox(
        height: 5,
      ),
      myDrawerButton(
        label: 'My posts',
        icon: Icons.article,
        onPress: () {},
      ),
      SizedBox(
        height: 5,
      ),
      myDrawerButton(
        label: 'Invite friends',
        icon: Icons.mail,
        onPress: () {},
      ),
      SizedBox(
        height: 5,
      ),
      myDrawerButton(
        label: 'Help Center',
        icon: Icons.help_outline,
        onPress: () {},
      ),
      SizedBox(
        height: 5,
      ),
      myDrawerButton(
        label: 'Connect with us',
        icon: Icons.phone,
        onPress: () {},
      ),
      SizedBox(
        height: 5,
      ),
      myDrawerButton(
        label: 'privacy policy',
        icon: Icons.privacy_tip,
        onPress: () {},
      ),
      SizedBox(
        height: 5,
      ),
      myDrawerButton(
        label: 'Logout',
        icon: Icons.logout,
        onPress: () {
          BlocProvider.of<AuthCubit>(context).logOut(context);
        },
      ),
    ],
  );
}


void _showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String selectedLanguage = 'english'; // Default selected value

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Capital Estate',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Constants.mainColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Constants.mainColor,
                    thickness: 1,
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text(
                      'Arabic',
                      style: TextStyle(
                        color: Constants.mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Radio<String>(
                      value: 'arabic',
                      groupValue: selectedLanguage,
                      activeColor: Constants.mainColor,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'English',
                      style: TextStyle(
                        color: Constants.mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: Radio<String>(
                      value: 'english',
                      groupValue: selectedLanguage,
                      activeColor: Constants.mainColor,
                      onChanged: (value) {
                        setState(() {
                          selectedLanguage = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Constants.mainColor4,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print(selectedLanguage == 'arabic' ? "Arabic" : "English");
                  Navigator.of(context).pop();

                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    },
  );
}
// void _shareInvite(BuildContext context) {
//   final String text = "هل سمعت عن كابيتال ستيت؟ إنه تطبيق رائع لتسويق بيع وشراء واستئجار العقارات وللتحميل .....";
//
//   Share.share(
//     text,
//     subject: 'Invite to App',
//   );
// }
