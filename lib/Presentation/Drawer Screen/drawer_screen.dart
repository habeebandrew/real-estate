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
  int? typeofuser;

  void initState() {
    super.initState();
    fetchStoredValue();
    fetchtypeofuser();
  }

  void fetchStoredValue() {
    setState(() {
      storedValue = CacheHelper.getString(key: 'name');
    });
  }
void fetchtypeofuser(){setState(() {
  typeofuser=CacheHelper.getInt(key: 'role_id');
});}

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

              typeofuser == null
            ? _build_for_guest()
            : typeofuser == 1 ? _build_for_user() :(typeofuser==2?_build_for_Broker():Text("Error confirming identity")),

        //هون كمان بس يزبط الباك بضيف اذا احتمال اذا كان سمسار
            ],
          ),
        ),
      ),
    );
  }
  //هون حسب مين مسجل دحول بيطلعو الخيارات
  Widget _build_for_guest() {

        return SingleChildScrollView(
          child: Column(
            children: [
              myDrawerButton(
                  label: 'language',
                  icon: Icons.language,
                  onPress: (){}
              ),
              SizedBox(height: 5,),
              myDrawerButton(
                  label: 'Invite friends',
                  icon: Icons.mail,
                  onPress: (){}
              ),
              SizedBox(height: 5,),
              myDrawerButton(
                  label: 'Help Center',
                  icon: Icons.help_outline,
                  onPress: (){}
              ),
              SizedBox(height: 5,),
              myDrawerButton(
                  label: 'Connect with us',
                  icon: Icons.phone,
                  onPress: (){}
              ),
              SizedBox(height: 5,),
              myDrawerButton(
                  label: 'privacy policy',
                  icon: Icons.person,
                  onPress: (){}
              ),
              SizedBox(height: 5,),
              myDrawerButton(
                label: 'Login',
                icon: Icons.login,
                onPress: () {
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
          
                },
              ),
            ],
          ),
        );

  }
  Widget _build_for_user() {
    return
         SingleChildScrollView(
           child: Column(
            children: [
              myDrawerButton(
                  label: 'Account Information',
                  icon: Icons.person,
                  onPress: (){}
              ),
              SizedBox(height: 5,),

              myDrawerButton(
                label: 'language',

                icon: Icons.language,
                onPress: () {

                },
              ),              SizedBox(height: 5,),

              myDrawerButton(
                label: 'My posts',

                icon: Icons.article,
                onPress: () {

                },
              ),              SizedBox(height: 5,),

              myDrawerButton(
                label: 'Invite friends',

                icon: Icons.mail,
                onPress: () {

                },
              ),              SizedBox(height: 5,),

              myDrawerButton(
                label: 'Help Center',

                icon: Icons.help_outline,
                onPress: () {

                },
              ),              SizedBox(height: 5,),

              myDrawerButton(
                label: 'Connect with us',

                icon: Icons.phone,
                onPress: () {

                },
              ),              SizedBox(height: 5,),

              myDrawerButton(
                label: 'privacy policy',

                icon: Icons.privacy_tip,
                onPress: () {

                },
              ),              SizedBox(height: 5,),

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
  Widget _build_for_Broker() {
    return
         Column(
          children: [
            myDrawerButton(
                label: 'Account Information',
                icon: Icons.person,
                onPress: (){}
            ),              SizedBox(height: 5,),

            myDrawerButton(
              label: 'language',

              icon: Icons.language,
              onPress: () {

              },
            ),              SizedBox(height: 5,),

            myDrawerButton(
              label: 'My real estate',

              icon: Icons.home,
              onPress: () {

              },
            ),              SizedBox(height: 5,),

            myDrawerButton(
              label: 'My posts',

              icon: Icons.article,
              onPress: () {

              },
            ),              SizedBox(height: 5,),

            myDrawerButton(
              label: 'Invite friends',

              icon: Icons.mail,
              onPress: () {

              },
            ),              SizedBox(height: 5,),

            myDrawerButton(
              label: 'Help Center',

              icon: Icons.help_outline,
              onPress: () {

              },
            ),              SizedBox(height: 5,),

            myDrawerButton(
              label: 'Connect with us',

              icon: Icons.phone,
              onPress: () {

              },
            ),              SizedBox(height: 5,),

            myDrawerButton(
              label: 'privacy policy',

              icon: Icons.privacy_tip,
              onPress: () {

              },
            ),              SizedBox(height: 5,),

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
}

