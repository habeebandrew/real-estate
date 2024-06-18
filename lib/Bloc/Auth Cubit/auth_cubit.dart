
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_service.dart';
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
      var data = await AuthService.login(
          email: logInEmailController.text,
          password: passwordController.text,
      );
      if(data != null){
        emit(AuthLoadedState());
        await CacheHelper.putString(key: 'name', value: data.user.username);
        await CacheHelper.putString(key: 'token', value: data.accessToken);
        mySnackBar(
          context: context,
          title: 'login successful',
        );
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
    }
  }


  void signUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(AuthLoadingState());
      var data = await AuthService.signUp(
        user_name: user_nameController.text,
        email: emailController.text,
        password: signUPasswordController.text,
        passwordConfirm: confirmPasswordController.text,
      );
      if (data != null) {
        emit(AuthLoadedState());
        await CacheHelper.putString(key: 'name', value: data.user.username);
        await CacheHelper.putString(key: 'token', value: data.accessToken);
        mySnackBar(
          context: context,
          title: 'Registration successful',
        );
        // Delay for 2 seconds and then navigate to the next screen
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.homeScreen));
        });
        resetFormFields();

      } else {
        resetFormFields();
        emit(AuthErrorState(message: 'Failed to register. Please try again later.'));
      }
    }
  }
}
