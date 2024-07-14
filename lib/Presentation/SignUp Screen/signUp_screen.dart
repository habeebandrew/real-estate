import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_cubit.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';
import 'package:pro_2/Util/global%20Widgets/my_button.dart';
import 'package:pro_2/Util/global%20Widgets/my_form_field.dart';
import 'package:pro_2/generated/l10n.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            mySnackBar(
              context: context,
              color: Colors.red,
              title: 'Registration failed: ${state.message}',
            );
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
                        S.of(context).Signup_user,
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: Constants.mainColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.h),
                      MyFormField(
                        maxLines: 1,
                        controller: cubit.user_nameController,
                        labelText: S.of(context).User_Name,
                        maxLength: 55,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).Please_name;
                          } else if (value.length > 55) {
                            return S.of(context).User_name_characters;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      MyFormField(
                        maxLines: 1,
                        controller: cubit.emailController,
                        labelText: S.of(context).email,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).Please_email;
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return S.of(context).Please_valid_email;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      MyFormField(
                        maxLines: 1,
                        controller: cubit.signUPasswordController,
                        labelText: S.of(context).Password,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).Please_password;
                          } else if (value.length < 8) {
                            return S.of(context).Password_characters_long;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      MyFormField(
                        maxLines: 1,
                        controller: cubit.confirmPasswordController,
                        labelText: S.of(context).Confirm_Password,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).Please_confirm_password;
                          } else if (value !=
                              cubit.signUPasswordController.text) {
                            return S.of(context).Passwords_match;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      state is AuthLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : MyButton(
                              tittle: S.of(context).Sign_up,
                              onPreessed: () {
                                cubit.signUp(context);
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
      ),
    );
  }
}
