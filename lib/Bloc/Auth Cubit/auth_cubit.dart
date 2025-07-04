import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_service.dart';
import 'package:pro_2/Bloc/Posts%20Cubit/posts_cubit.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_service.dart';
import 'package:pro_2/Presentation/Auctions/Add_Auction_screen.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';
import '../../Util/app_routes.dart';
import '../../Util/global Widgets/animation.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState>
{
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context)=>BlocProvider.of(context);

  //Log In
  final TextEditingController logInEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();
  //SignUp
  final formKey = GlobalKey<FormState>();
  final user_nameController = TextEditingController();
  final emailController = TextEditingController();
  final signUPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
//bottomNav
  int currentIndex = 4;
  List<Widget> screens = [
    AppRoutes.postsScreen,
    AppRoutes.auction_screen,
    AppRoutes.adPropertyScreen,
    AppRoutes.propertiesScreen,
    // AppRoutes.showsharing,

    AppRoutes.mainScreen,
  ];

  void bottomNavChange(int value,BuildContext context){
    emit(NavChangeState());
    currentIndex=value;
    //الشرط هون بدنا نعمل لكل كبسة بلبوتوم لانو لما يكبس عليها لازم ينضرب ريكوست الغيت لعرض الواجهة
    //الهدف من هل حركة لنخلي الكيوبت يلي فيو فانكشن تغيير البوتوم الموجود بهل كيوبت يتصل مع باقي الكيوبت من اجل كل كبسة بأنو كيوب مرتبطة
    //وهاد مثال عن هل حكي
    if(currentIndex ==0){
      context.read<PostsCubit>().pressed();
    } if(currentIndex ==1){
      //context.read<PropertyCubit>().getMyFavourite(context);
    }
    if(currentIndex==3){
      context.read<PropertyCubit>().getProperty(context, (CacheHelper.getInt(key: 'id'))!);
    }
  }

  void resetFormFields() {
    user_nameController.clear();
    emailController.clear();
    signUPasswordController.clear();
    confirmPasswordController.clear();
  }
  void logIn(BuildContext context)async
  {
    if (logInFormKey.currentState!.validate()){
      emit(AuthLoadingState());
      await AuthService.login(
        email: logInEmailController.text,
        password: passwordController.text,
      ).then((value)async
      {
        if(value != null){
          emit(AuthLoadedState());
          mySnackBar(
            context: context,
            title: 'login successful',
          );
          await CacheHelper.putString(key: 'name', value: value.user.username);
          await CacheHelper.putInt(key: 'role_id', value: value.user.roleId);
          await CacheHelper.putInt(key: 'id', value: value.user.id);
          await CacheHelper.putString(key: 'image', value: value.image);
          await CacheHelper.putString(key: 'token', value: value.accessToken);
          try{
            await CacheHelper.putString(key: 'number', value: value.number!);
          }catch(e){print(e);
          await CacheHelper.putString(key: 'number', value: '');

          print("error in num!");}
          logInEmailController.clear();
          passwordController.clear();
          // Delay for 2 seconds and then navigate to the next screen
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.homeScreen));
          });

        } else {
          logInEmailController.clear();
          passwordController.clear();
          emit(AuthErrorState(message: 'Failed to login. Please try again later.'));
        }
      });

    }
  }


  void signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(AuthLoadingState());

      try {
        // استخدم await للتأكد من انتظار استجابة الـ API
        final responseMessage = await AuthService.signUp(
          user_name: user_nameController.text,
          email: emailController.text,
          password: signUPasswordController.text,
          passwordConfirm: confirmPasswordController.text,
          context: context
        );
        await CacheHelper.putString(value:user_nameController.text,key: 'user_name_verify');
print(user_nameController.text);
        if (responseMessage != null && responseMessage.contains("The code is sent")) {
          emit(AuthLoadedState());
          mySnackBar(
            context: context,
            title: responseMessage, // عرض الرسالة الواردة من الاستجابة
          );

          // تأخير لمدة 2 ثانية ثم الانتقال إلى الشاشة التالية
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).push(
              MyAnimation.createRoute(AppRoutes.emailVerificationScreen),
            );
          });

          resetFormFields();
        } else {

          emit(AuthErrorState(message: 'Failed to register. Please try again later.'));
          resetFormFields();
        }

      } catch (e) {
        emit(AuthErrorState(message: 'An unexpected error occurred. Please try again later.'));
        resetFormFields();
      }
    }
  }

  void logOut(BuildContext context) async {
    emit(AuthLoadingState());
    final navigator = Navigator.of(context);
    await CacheHelper.deleteString(key: 'name');
    await CacheHelper.deleteInt(key: 'role_id');
    await CacheHelper.deleteString(key: 'token');
    emit(AuthLoadedState());
    navigator.push(MyAnimation.createRoute(AppRoutes.logInScreen));
  }
}


