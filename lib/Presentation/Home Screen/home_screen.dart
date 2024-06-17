import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Presentation/Home%20Screen/Home%20Widgets/home_widgets.dart';
import 'package:pro_2/Presentation/Home%20Screen/drawer_screen.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/constants.dart';

class HomeScreen extends StatefulWidget {


  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomePageState();
}
class _HomePageState extends State<HomeScreen> {
  int currentIndex=0;
  List<Widget>Screens=[
    AppRoutes.postsScreen,
    AppRoutes.favouriteScreen,
    AppRoutes.adPropertyScreen,
    AppRoutes.propertiesScreen,
    AppRoutes.mainScreen,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'هون لازم اسم التطبيق وجنبو اللوغو '
        ),
      ),
      endDrawer: const DrawerScreen(),
      body: Screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        child:Icon(
          color: currentIndex==2?Constants.mainColor4:Colors.black45,
          Icons.add,
          size: 40.0.sp,
        ),
        onPressed: (){},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Constants.mainColor,
        selectedItemColor: Constants.mainColor4,
        unselectedItemColor: Colors.black45,
        onTap: (value){
           setState(() {
             Screens[currentIndex=value];

           });
        },
        items:  [
          myBottomNavBarItem(
              icon: Icons.announcement,
              label: 'Posts'
          ),
          myBottomNavBarItem(
              icon: Icons.favorite,

              label: 'Favourite'
          ),
          myBottomNavBarItem(
              icon: Icons.cabin,
              label: 'Ad'
          ),
          myBottomNavBarItem(
              icon: Icons.holiday_village,
              label: 'Properties'
          ),
          myBottomNavBarItem(
              icon: Icons.home,
              label: 'Home'
          ),

        ],
      ),

    );
  }
}
