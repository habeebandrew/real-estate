import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Auth%20Cubit/auth_cubit.dart';
import 'package:pro_2/Util/app_routes.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';
import 'package:pro_2/Util/global Widgets/my_button.dart';
import 'package:pro_2/Util/global%20Widgets/animation.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';
import 'package:pro_2/Util/global%20Widgets/my_form_field.dart';


class LogInScreen extends StatelessWidget {

   const LogInScreen({super.key});

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
          title: 'LogIn failed: ${state.message}',
        );
      }
    },
    builder: (context, state) {
      AuthCubit cubit=AuthCubit.get(context);
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Dimensions.heightPercentage(context, 5),
              ),
              Image.asset(
                'assets/images/authentication/test1.png',
                height: Dimensions.heightPercentage(context, 40),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    color: Constants.mainColor4,
                    elevation: 8.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: cubit.logInFormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(height: 20.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: MyFormField(
                                controller: cubit.logInEmailController,
                                labelText: 'email',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: MyFormField(maxLines: 1,
                                controller: cubit.passwordController,
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
                            ),
                            const SizedBox(height: 20.0),
                            state is AuthLoadingState?
                            const Center(
                                child: CircularProgressIndicator()
                            )
                                :MyButton(
                                tittle: "Log in",
                                onPreessed: () {
                                  cubit.logIn(context);
                                },
                                minWidth: Dimensions.widthPercentage(context, 50),
                                height:Dimensions.heightPercentage(context, 7),
                            ),
                            TextButton(
                                onPressed: () {

                                  //Not now
                                },
                                child:  const Text(
                                  "Forget the password?",
                                  style: TextStyle(color: Constants.mainColor),
                                )),
                            SizedBox(
                              height: Dimensions.heightPercentage(context, 2),
                            ),
                            Row(
                              children: [
                                 const Text(
                                  "new member?",
                                  style: TextStyle(
                                      color: Constants.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                TextButton(
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: Dimensions.heightPercentage(context, 20),
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  leading: const Icon(Icons.person_add),
                                                  title: const Text('Sign Up'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.of(context)
                                                        .push(MyAnimation.createRoute(AppRoutes.signUpScreen));
                                                  },
                                                ),
                                                const Divider(),
                                                ListTile(
                                                  leading: const Icon(
                                                      Icons.no_accounts_outlined),
                                                  title: const Text('Log in as guest'),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    Navigator.of(context)
                                                        .push(MyAnimation.createRoute(AppRoutes.homeScreen));
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                    );
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
   ),
);
  }
}

