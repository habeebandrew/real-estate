
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_service.dart';


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

   void SignUp()async
   {
     if (formKey.currentState!.validate()) {
       emit(AuthLoadingState());
       var data = await AuthService.signUp(
           firstName: firstNameController.text,
           lastName: lastNameController.text,
           email: emailController.text,
           password: signUPasswordController.text,
           passwordConfirm: confirmPasswordController.text
       );
       if (data != null) {
         //(///هيك بتصل للتوكن (user.accessToken
         emit(AuthLoadedState());
       }
     }
   }
   void LogIn()async{}

}
