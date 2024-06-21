// ignore_for_file: unused_element, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_cubit.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/animation.dart';

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
        myDrawerButton(label: 'language', icon: Icons.language, onPress: () {}),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
            label: 'Invite friends', icon: Icons.mail, onPress: () {}),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
            label: 'Help Center', icon: Icons.help_outline, onPress: () {}),
        SizedBox(
          height: 5,
        ),
        myDrawerButton(
            label: 'Connect with us', icon: Icons.phone, onPress: () {}),
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




