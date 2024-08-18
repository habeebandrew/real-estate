import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_cubit.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Presentation/Main%20Screen/MainWidgets/main_widgets.dart';
import 'package:pro_2/Presentation/Main%20Screen/MainWidgets/sharingwidget.dart';
import 'package:pro_2/Presentation/Notification/notification_function.dart';
import 'package:pro_2/generated/l10n.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../../Util/cache_helper.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _ipController = TextEditingController();
  String? _ip;

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
          if (!isAllowed)
            {AwesomeNotifications().requestPermissionToSendNotifications()}
        });
    // طلب الإذن للإشعارات إذا لم يكن ممنوحاً
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
    // جدولة الإشعارات
    // scheduleDailyNotification();

    // جدولة الإشعارات
    // showNotification();

    // _loadIp();
  }

  // Future<void> _loadIp() async {
  //   String? ip = CacheHelper.getString(key: 'ip');
  //   setState(() {
  //     _ip = ip;
  //     _ipController.text = ip ?? '';
  //   });
  // }
  //
  // Future<void> _updateIp() async {
  //   String newIp = _ipController.text;
  //   await CacheHelper.putString(key: 'ip', value: newIp);
  //   setState(() {
  //     _ip = newIp;
  //   });
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Color.fromARGB(255, 255, 255, 255),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // TextField(
            //   controller: _ipController,
            //   decoration: InputDecoration(
            //     hintText: _ip ?? 'Enter IP Address',
            //   ),
            // ),
            // TextButton(
            //   onPressed: (){_updateIp();print(_ipController);},
            //
            //   child: Text('Update IP'),
            // ),
            SearchBar(), //باخدها نفسها من مهدي بواجهة العقارات
            CategorySection(),
            SizedBox(height: 20),

            // Padding(
            //   padding: const EdgeInsets.all(12.0),
            //   child: Row(
            //     children: [
            //       Text(
            //         S.of(context).most_watched,
            //         style: TextStyle(
            //           color: Colors.black87,
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       Icon(Icons.visibility)
            //     ],
            //   ),
            // ),
            // SharingTimeScreen(),
            // mostviewer(),
            ActionCard(
              title: 'الملكية المشتركة',
              subtitle: "استمتع بتجربة الفخامة والراحة من خلال امتلاك حصة زمنية في عقار فاخر. حجزك لجزء من السنة يضمن لك عطلة لا تُنسى في كل عام، مع مرونة في التوقيت والموقع."
                ,
              icon: Icons.home
            ),
            SizedBox(
              height: 50,
            )
            // AdBanner(),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: S.of(context).Search_real,
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
