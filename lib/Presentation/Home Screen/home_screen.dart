import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_cubit.dart';
import 'package:pro_2/Bloc/Posts%20Cubit/posts_cubit.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Presentation/Home%20Screen/Home%20Widgets/home_widgets.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:flutter/services.dart';

import '../../Util/dimensions.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          create: (context) => PropertyCubit(),
        ),
        BlocProvider(
          create: (context) => PostsCubit(),
        ),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          AuthCubit cubit =AuthCubit.get(context);
          return Scaffold(backgroundColor: Colors.white,
            endDrawer: AppRoutes.drawerScreen,
            body: WillPopScope( onWillPop: () async {

              return await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Do you really want to go out?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('no'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: Text('yes'),
                      onPressed: () {SystemNavigator.pop();

                      Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                ),
              );
            },
                child:
              CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: <Widget>[
                  //silver منشان لما اعمل scroll down تضل ابيض ما تغمق
                  SliverAppBar(
                    automaticallyImplyLeading: false, // لإزالة زر الرجوع
                    backgroundColor: Colors.white,
                    pinned: true, // يعني أنه يبقى مثبتًا في الأعلى
                    title: Row(
                      children: [
                        Image.asset(
                          "assets/images/General/App_Icon1.png",
                          height: Dimensions.heightPercentage(context, 6.5),
                        ),
                        const SizedBox(width: 5,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'C',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Constants.mainColor,
                                  fontSize: 30.h,
                                ),
                              ),
                              TextSpan(
                                text: 'apital',
                                style: TextStyle(
                                  color: Constants.mainColor,
                                  fontSize:26.h,
                                ),
                              ),
                              TextSpan(
                                text: ' E',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Constants.mainColor,
                                  fontSize: 30.h,
                                ),
                              ),
                              TextSpan(
                                text: 'states',
                                style: TextStyle(
                                  color: Constants.mainColor,
                                  fontSize: 26.h,
                                ),
                              ),
                            ],
                          ),
                        ),
              
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    child: cubit.screens[cubit.currentIndex],
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 40.0.sp,
              ),
              onPressed: () {},
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation
                .centerDocked,
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              backgroundColor: Colors.white,
              selectedItemColor: Constants.mainColor,
              unselectedItemColor: Constants.mainColor2,
              onTap: (value) {
                cubit.bottomNavChange(value, context);
              },
              items: [
                myBottomNavBarItem(
                  icon: Icons.announcement,
                  label: 'Posts',
                ),
                myBottomNavBarItem(
                  icon: Icons.favorite,
                  label: 'Favourite',
                ),
                myBottomNavBarItem(
                  icon: Icons.add,
                  label: 'add',
                ),
                myBottomNavBarItem(
                  icon: Icons.holiday_village,
                  label: 'Properties',
                ),
                myBottomNavBarItem(
                  icon: Icons.home,
                  label: 'Home',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
