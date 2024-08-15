import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_cubit.dart';
import 'package:pro_2/Bloc/Posts%20Cubit/posts_cubit.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Presentation/Home%20Screen/Home%20Widgets/home_widgets.dart';
import 'package:pro_2/Presentation/Notification/api_service.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:flutter/services.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/cache_helper.dart';
import '../../Util/dimensions.dart';
import '../../Util/global Widgets/animation.dart';
import '../../Util/network_helper.dart';
import '../../generated/l10n.dart';
import '../Notification/notification_function.dart';
import 'package:http/http.dart' as http;
Future<dynamic> fetchUnreadCount(BuildContext context) async {
  String? token = await CacheHelper.getString(key: 'token');

  if (token == null) {
  }else{
    fetchNotifications();

  String token = (await CacheHelper.getString(key: 'token'))!;
  final response = await NetworkHelper.get(
    ApiAndEndpoints.showCountMyNotification,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    print(jsonResponse);
    return jsonResponse ?? 0;
  } else {
    throw Exception('Failed to load u/nread count');
  }

}}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int unreadCount = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _checkNumberValue();
    // _timer = Timer.periodic(Duration(seconds: 40), (Timer t) =>     _checkNumberValue()
    // );

    _fetchUnreadCount();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _fetchUnreadCount());
  }
//
  Future<void> _checkNumberValue() async {
    String? number = await CacheHelper.getString(key: 'number');
    print(number);

    if (number ==null) {
      _showMandatoryAddNumberDialog(context);
   }
  }
  @override
  void dispose() {

      _timer.cancel();
    super.dispose();
  }

  Future<void> _fetchUnreadCount() async {
    try {
      final count = await fetchUnreadCount(context);
      setState(() {
        unreadCount = count;
      });
    } catch (e) {
      print('Error fetching unread count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => PropertyCubit()),
        BlocProvider(create: (context) => PostsCubit()),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            endDrawer: AppRoutes.drawerScreen,
            body: WillPopScope(
              onWillPop: () async {
                return await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(S.of(context).go_out),
                    actions: <Widget>[
                      TextButton(
                        child: Text(S.of(context).no),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                      TextButton(
                        child: Text(S.of(context).yes),
                        onPressed: () {
                          SystemNavigator.pop();
                          Navigator.of(context).pop(true);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    pinned: true,
                    leadingWidth: 0.0,
                    titleSpacing: 0.0,
                    centerTitle: true,
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      
                      children: [
                        Image.asset(
                          "assets/images/General/App_Icon1.png",
                          height: Dimensions.heightPercentage(context, 6.5),
                        ),
                      
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'C',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Constants.mainColor,
                                  fontSize: 26.h,
                                ),
                              ),
                              TextSpan(
                                text: 'apital',
                                style: TextStyle(
                                  color: Constants.mainColor,
                                  fontSize: 22.h,
                                ),
                              ),
                              TextSpan(
                                text: ' E',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Constants.mainColor,
                                  fontSize: 26.h,
                                ),
                              ),
                              TextSpan(
                                text: 'states',
                                style: TextStyle(
                                  color: Constants.mainColor,
                                  fontSize: 22.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        IconButton(
                         onPressed: (){
                            Navigator.push(context, MyAnimation.createRoute(AppRoutes.favouriteScreen));
                         },
                         icon: const Icon(
                          Icons.favorite_border,
                         ),
                        ),
                        
                      
                        Stack(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications_none_rounded),
                              onPressed: () {
                                showNotificationSheet(context);
                              },
                            ),
                             if (unreadCount !=0)
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  constraints: BoxConstraints(minWidth: 10, minHeight: 10),
                                  child: Center(
                                    child: Text(
                                      unreadCount.toString(),
                                      style: TextStyle(
                                        color: Colors.white,fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                          ],
                        ),
                        // Spacer(),
                        //
                        // Padding(
                        //   padding: const EdgeInsets.all(1.0),
                        //   child: IconButton(icon:Icon(Icons.favorite_border),iconSize: 0.1, onPressed: (){},),
                        // )
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
                _handleFloatingActionButton(context);
              },
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                myBottomNavBarItem(icon: Icons.announcement, label: S.of(context).Posts),
                myBottomNavBarItem(icon: Icons.price_change, label: 'Auctions'),
                myBottomNavBarItem(icon: Icons.add, label: S.of(context).Add),
                myBottomNavBarItem(icon: Icons.holiday_village, label: S.of(context).Properties),
                myBottomNavBarItem(icon: Icons.home, label: S.of(context).Home),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleFloatingActionButton(BuildContext context) {
    int? role_id = CacheHelper.getInt(key: 'role_id');
    if (role_id == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              S.of(context).alert,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            content: Text(S.of(context).Please_log_in),
            actions: <Widget>[
              TextButton(
                child: Text(
                  S.of(context).Log_In,
                  style: TextStyle(color: Constants.mainColor, fontWeight: FontWeight.bold),
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
    } else if (role_id == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              S.of(context).Add,
              style: TextStyle(color: Constants.mainColor, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Text(
                              S.of(context).alert,
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                            content: Text(S.of(context).Please_subscription),
                            actions: <Widget>[
                              TextButton(
                                child: Text(
                                  S.of(context).Subscription,
                                  style: TextStyle(color: Constants.mainColor, fontWeight: FontWeight.bold),
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
                    },
                    child: ListTile(
                      leading: Icon(Icons.info, color: Constants.mainColor),
                      title: Text(S.of(context).Add_real),
                    ),
                  ),
                  Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.addPost));
                    },
                    child: ListTile(
                      leading: Icon(Icons.info, color: Constants.mainColor),
                      title: Text(S.of(context).Add_post),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  S.of(context).close,
                  style: TextStyle(color: Constants.mainColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else if (role_id == 2) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            title: Text(
              S.of(context).Add,
              style: TextStyle(color: Constants.mainColor, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.adPropertyScreen));
                    },
                    child: ListTile(
                      leading: Icon(Icons.info, color: Constants.mainColor),
                      title: Text(S.of(context).Add_real),
                    ),
                  ),
                  Divider(),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.addPost));
                    },
                    child: ListTile(
                      leading: Icon(Icons.info, color: Constants.mainColor),
                      title: Text(S.of(context).Add_post),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  S.of(context).close,
                  style: TextStyle(color: Constants.mainColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}void _showMandatoryAddNumberDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // يمنع إغلاق الحوار بالضغط خارجها
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
S.of(context).alert,
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        content: Text(S.of(context).Please_number),
        actions: <Widget>[
          Center(
            child: TextButton(
              child: Text(
                S.of(context).Enter_new_number,
                style: TextStyle(color: Constants.mainColor, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop(); // أغلق الحوار
                Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.accountInfoPage));
              },
            ),
          ),
        ],
      );
    },
  );
}