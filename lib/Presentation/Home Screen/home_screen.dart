import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Presentation/Home%20Screen/Home%20Widgets/home_widgets.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int currentIndex = 4;
  List<Widget> screens = [
    AppRoutes.postsScreen,
    AppRoutes.favouriteScreen,
    AppRoutes.adPropertyScreen,
    AppRoutes.propertiesScreen,
    AppRoutes.mainScreen,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppRoutes.drawerScreen,
      body: CustomScrollView(
        slivers: <Widget>[
          //silver منشان لما اعمل scroll down تضل ابيض ما تغمق
          SliverAppBar(        automaticallyImplyLeading: false, // لإزالة زر الرجوع

            backgroundColor: Colors.white,
            pinned: true, // يعني أنه يبقى مثبتًا في الأعلى
            title: Row(
              children: [
                Image.asset(
                  "assets/images/General/App_Icon.png",
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                SizedBox(width: 10,),
                const Text('Real Estate'),
              ],
            ),
          ),
          SliverFillRemaining(
            child: screens[currentIndex],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 40.0.sp,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        selectedItemColor: Constants.mainColor,
        unselectedItemColor: Constants.mainColor2,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
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
  }
}

// Widget لإنشاء عنصر في قائمة BottomNavigationBar
BottomNavigationBarItem myBottomNavBarItem({required IconData icon, required String label}) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
  );
}
