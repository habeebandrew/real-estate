import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Presentation/Drawer%20Screen/Drawer%20Widgets/drawer_widgets.dart';
import 'package:pro_2/Util/dimensions.dart';
import '../../Bloc/Auth Cubit/auth_cubit.dart';

import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/constants.dart';
import '../../Util/global Widgets/animation.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String? storedValue;

  void initState() {
    super.initState();
    fetchStoredValue();
  }

  void fetchStoredValue() {
    setState(() {
      storedValue = CacheHelper.getString(key: 'name');
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      width: Dimensions.screenWidth(context)/1.5,
      elevation: 0.0,
      child:   Material(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(backgroundImage: AssetImage("assets/images/General/App_Icon.png"),
                radius: 40.0,backgroundColor: Colors.white,
              ),
              const SizedBox(
                height: 10.0,
              ),
              storedValue != null
                  ?
               Text(
                storedValue ?? 'No value stored',
                style: TextStyle(fontSize: 24),
              ): SizedBox(),
              Divider(color: Constants.mainColor,
               indent: Dimensions.widthPercentage(context, 3),
               endIndent: Dimensions.widthPercentage(context, 2),
              ),
              myDrawerButton(
                  label: 'Account Information',
                  icon: Icons.person,
                  onPress: (){}
              ),
// هون الشرط منشان اذا كان فايت ك زائر ****
              storedValue != null
                  ? myDrawerButton(
                label: 'Logout',
                icon: Icons.logout,
                onPress: () {
                  BlocProvider.of<AuthCubit>(context).logOut(context);
                },
              ):
             //SizedBox(),
              myDrawerButton(
                label: 'Login',
                icon: Icons.login,
                onPress: () {
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));

                },
              ),
              myDrawerButton(
                label: 'My real estate',

                icon: Icons.home,
                onPress: () {
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));

                },
              ),
              myDrawerButton(
                label: 'My posts',

                icon: Icons.article,
                onPress: () {
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));

                },
              ),
              myDrawerButton(
                label: 'My favorite',

                icon: Icons.favorite,
                onPress: () {
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));

                },
              ),
              myDrawerButton(
                label: 'Invite friends',

                icon: Icons.mail,
                onPress: () {
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));

                },
              ),
              myDrawerButton(
                label: 'Help Center',

                icon: Icons.help_outline,
                onPress: () {
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));

                },
              ),
              myDrawerButton(
                label: 'Connect with us',

                icon: Icons.phone,
                onPress: () {
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));

                },
              ),
              myDrawerButton(
                label: 'privacy policy',

                icon: Icons.privacy_tip,
                onPress: () {
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));

                },
              ),
              myDrawerButton(
                label: 'language',

                icon: Icons.language,
                onPress: () {
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

