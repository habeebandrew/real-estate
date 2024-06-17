import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_cubit.dart';
import 'package:pro_2/Util/app_bloc_observer.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Util/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  bool? onBoardShowen = CacheHelper.getData(key: "showHome") ?? false;
  String? token = CacheHelper.getString(key: "token");
  debugPrint(onBoardShowen.toString());
  debugPrint(token.toString());

  Bloc.observer = MyBlocObserver();

  runApp(MyApp(onBoardShowen: onBoardShowen,token: token,));
}

class MyApp extends StatelessWidget {
  final bool onBoardShowen;
  final String?token;

  const MyApp({
    super.key,
    this.token,
    required this.onBoardShowen,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),

      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Real Estate',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Constants.mainColor
                ),
                progressIndicatorTheme: const ProgressIndicatorThemeData(
                  color: Constants.mainColor,
                ),
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  elevation: 0.0,
                  backgroundColor: Constants.mainColor,
                  foregroundColor: Constants.mainColor4,
                  shape: CircleBorder(
                  ),
                ),
                useMaterial3: true,
                textTheme: const TextTheme(
                  //نعرف الخطوط اللازمة
                ),
              ),
              initialRoute:token!=null
                  ?NamedRoutes.splashscreen
                  :onBoardShowen==true
                  ?NamedRoutes.logInScreen
                  :NamedRoutes.onBoardingScreen,
              //token!=null?onBoardShowen==true?NamedRoutes.signUpScreen:NamedRoutes.onBoardingScreen:NamedRoutes.logInScreen,
              routes: AppRoutes.routes,
            ),
          );
        },
      ),
    );
  }
}
