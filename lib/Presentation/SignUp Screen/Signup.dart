import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_cubit.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';
import 'package:pro_2/Util/global%20Widgets/my_button.dart';
import 'package:pro_2/Util/global%20Widgets/my_form_field.dart';

import '../../Util/app_routes.dart';
import '../../Util/global Widgets/animation.dart';

class SignUp extends StatelessWidget {


    const SignUp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          mySnackBar(
            context: context,
            title: 'Registration failed: ${state.message}',
          );
          if(state is AuthLoadedState){
            mySnackBar(
              context: context,
              title: 'Registration successful',
            );
          }
      }

      },
      builder: (context, state) {
        AuthCubit cubit = AuthCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.h),
                    Image.asset(
                      'assets/images/authentication/test1.png',
                      height: 150.h,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Sign up as a user",
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Constants.mainColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20.h),
                    MyFormField(
                      controller: cubit.user_nameController,
                      labelText: 'User Name',
                      maxLength: 55,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your User name';
                        } else if (value.length > 55) {
                          return 'User name cannot exceed 55 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    MyFormField(
                      controller: cubit.emailController,
                      labelText: 'Email',
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    MyFormField(
                      controller: cubit.signUPasswordController,
                      labelText: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    MyFormField(
                      controller: cubit.confirmPasswordController,
                      labelText: 'Confirm Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != cubit.signUPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    MyButton(
                      tittle: "Sign up",
                      onPreessed: () {
                        cubit.SignUp(context);
                      },
                      minWidth: Dimensions.widthPercentage(context, 50),
                      height: Dimensions.heightPercentage(context, 7),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
