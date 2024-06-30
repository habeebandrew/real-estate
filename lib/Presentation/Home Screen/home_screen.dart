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

import '../../Util/cache_helper.dart';
import '../../Util/dimensions.dart';
import '../../Util/global Widgets/animation.dart';

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
                        const SizedBox(width: 1,),
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
Spacer(),
                        IconButton(
                          icon: Icon(Icons.notifications_none_rounded),
                          onPressed: () {
                            // Handle the notification icon tap
                          },
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
              onPressed: () {
               int? role_id= CacheHelper.getInt(key: 'role_id');
                if(role_id==null){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                          'alert',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text('You do not have permission add any thing. Please log in!!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Log In',
                              style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
                            },
                          ),
                        ],
                      );
                    },
                  );


                }
               if(role_id==1){

                 showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return AlertDialog(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       title: Text(
                         'Add',
                         style: TextStyle(color: Constants.mainColor, fontWeight: FontWeight.bold),
                       ),
                       content: SingleChildScrollView(
                         child: Column(
                           // mainAxisSize: MainAxisSize.max,
                           children: <Widget>[
                             TextButton(
                               onPressed: (){
                               showDialog(
                                 context: context,
                                 builder: (BuildContext context) {
                                   return AlertDialog(
                                     shape: RoundedRectangleBorder(
                                       borderRadius: BorderRadius.circular(15),
                                     ),
                                     title: Text(
                                       'alert',
                                       style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                     ),
                                     content: Text('You do not have permission to add areal estate ad. Please subscription as a broker!!'),
                                     actions: <Widget>[
                                       TextButton(
                                         child: Text(
                                           'Subscription',
                                           style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                                         ),
                                         onPressed: () {
                                           Navigator.of(context).pop();
                                           Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.subscription));
                                         },
                                       ),
                                     ],
                                   );
                                 },
                               );
                               // Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.));
                             },
                               child: ListTile(
                                 leading: Icon(Icons.info, color: Constants.mainColor),
                                 title: Text('Add a real estate ad'),

                               ),
                             ),
                             Divider(),
                             TextButton(onPressed: (){Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.addPost));},
                               child: ListTile(
                                 leading: Icon(Icons.info, color: Constants.mainColor),
                                 title: Text('Add a post'),
                               ),
                             ),

                           ],
                         ),
                       ),
                       actions: <Widget>[
                         TextButton(
                           child: Text('إغلاق',style: TextStyle(color: Constants.mainColor),),
                           onPressed: () {
                             Navigator.of(context).pop();
                           },
                         ),
                       ],
                     );
                   },
                 );

               }
               if(role_id==2){
                 showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return AlertDialog(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15),
                       ),
                       title: Text(
                         'Add',
                         style: TextStyle(color: Constants.mainColor, fontWeight: FontWeight.bold),
                       ),
                       content: SingleChildScrollView(
                         child: Column(
                           // mainAxisSize: MainAxisSize.max,
                           children: <Widget>[
                             TextButton(onPressed: (){
                                Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.adPropertyScreen));
                               },
                               child: ListTile(
                                 leading: Icon(Icons.info, color: Constants.mainColor),
                                 title: Text('Add a real estate ad'),

                               ),
                             ),
                             Divider(),
                             TextButton(onPressed: (){Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.addPost));},
                               child: ListTile(
                                 leading: Icon(Icons.info, color: Constants.mainColor),
                                 title: Text('Add a post'),
                               ),
                             ),

                           ],
                         ),
                       ),
                       actions: <Widget>[
                         TextButton(
                           child: Text('إغلاق',style: TextStyle(color: Constants.mainColor),),
                           onPressed: () {
                             Navigator.of(context).pop();
                           },
                         ),
                       ],
                     );
                   },
                 );


               }
                // Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.addPost));
              },
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
                  label:
                   'Add'
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
