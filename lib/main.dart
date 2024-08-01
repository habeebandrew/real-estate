import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Presentation/Notification/notification.dart';
import 'package:pro_2/Presentation/SignUp%20Screen/verify_email.dart';
import 'package:pro_2/Presentation/map/map.dart';
import 'package:pro_2/Util/app_bloc_observer.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/generated/l10n.dart';
import 'package:pro_2/tests/360pic.dart';

void main() async {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white)
    ],
    debug: true,
  );
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  bool? onBoardShowen = CacheHelper.getData(key: "showHome") ?? false;
  String? token = CacheHelper.getString(key: "token");
  debugPrint(onBoardShowen.toString());
  debugPrint(token.toString());

  Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    onBoardShowen: onBoardShowen,
    token: token,
  ));
}

class MyApp extends StatefulWidget {
  final bool onBoardShowen;
  final String? token;

  const MyApp({
    super.key,
    this.token,
    required this.onBoardShowen,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en'); // تعيين اللغة الافتراضية هنا

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        locale: _locale,
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        title: 'Capital Estate',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Constants.mainColor),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Constants.mainColor,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 0.0,
            backgroundColor: Constants.mainColor,
            foregroundColor: Constants.mainColor4,
            shape: CircleBorder(),
          ),
          useMaterial3: true,
          textTheme: const TextTheme(
              //نعرف الخطوط اللازمة
              ),
        ),
         home:map(),
        // notification(),
        // EmailVerificationScreen(),
        // initialRoute:
            // NamedRoutes.adPropertyScreen,
            // widget.token != null
            //     ? NamedRoutes.splashscreen
            //     : widget.onBoardShowen == true
            //         ? NamedRoutes.logInScreen
            //         : NamedRoutes.onBoardingScreen,
        routes: AppRoutes.routes,
        builder: (context, child) {
          return LanguageChangeProvider(
            changeLanguage: _changeLanguage,
            child: child!,
          );
        },
      ),
    );
  }
}

class LanguageChangeProvider extends InheritedWidget {
  final Function(Locale) changeLanguage;
  const LanguageChangeProvider({
    required this.changeLanguage,
    required Widget child,
  }) : super(child: child);
  static LanguageChangeProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LanguageChangeProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
