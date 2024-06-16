
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_service.dart';

import '../../Util/app_routes.dart';
import '../../Util/global Widgets/animation.dart';


part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState>
{
  AuthCubit() : super(AuthInitialState());

  static AuthCubit get(context)=>BlocProvider.of(context);

   //Log In
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> logInFormKey = GlobalKey<FormState>();
  //SignUp
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final signUPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //لافراغ الحقول
  void resetFormFields() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    signUPasswordController.clear();
    confirmPasswordController.clear();
  }

  void LogIn()async{}

  void SignUp(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      emit(AuthLoadingState());
      var data = await AuthService.signUp(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        password: signUPasswordController.text,
        passwordConfirm: confirmPasswordController.text,
      );
      if (data != null) {
        emit(AuthLoadedState());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 2),
            content: Text('Registration successful'),
          ),
        );
        resetFormFields();

        // Delay for 2 seconds and then navigate to the next screen
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
        });
      } else {        resetFormFields();

      emit(AuthErrorState('Failed to register. Please try again later.'));
      }
    }
  }
}
