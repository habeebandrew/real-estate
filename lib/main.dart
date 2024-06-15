import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/cache_helper.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  bool? showHome = CacheHelper.getData(key: "showHome") ?? false;
  debugPrint(showHome.toString());

  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  final bool showHome;
  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,

      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Real Estate',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFBBAB8C)),
            useMaterial3: true,
          ),
          initialRoute:NamedRoutes.signUpScreen,
          routes:AppRoutes.routes ,
      ),
    );
  }
}
