// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:pro_2/Util/app_routes.dart';
// import 'package:pro_2/Util/global Widgets/mySnackBar.dart';
//
// import '../../Bloc/email_verification_cubit/email_verification_cubit.dart';
//
// class EmailVerificationScreen extends StatelessWidget {
//   final TextEditingController _codeController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => EmailVerificationCubit(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Email Verification'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: BlocConsumer<EmailVerificationCubit, EmailVerificationState>(
//             listener: (context, state) {
//               if (state is EmailVerificationSuccess) {
//                 // سيتم التعامل مع بيانات المستخدم هنا، ولكن تم معالجتها في الـ Cubit
//               } else if (state is EmailVerificationFailure) {
//                 mySnackBar(
//                   context: context,
//                   title: state.message,
//                 );
//               }
//             },
//             builder: (context, state) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   const Text(
//                     'Enter the 6-digit code sent to your email:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 30),
//                   PinCodeTextField(
//                     appContext: context,
//                     length: 6,
//                     controller: _codeController,
//                     animationType: AnimationType.fade,
//                     pinTheme: PinTheme(
//                       shape: PinCodeFieldShape.box,
//                       borderRadius: BorderRadius.circular(5),
//                       fieldHeight: 50,
//                       fieldWidth: 40,
//                       activeFillColor: Colors.white,
//                       inactiveFillColor: Colors.grey.shade200,
//                       selectedFillColor: Colors.grey.shade300,
//                       activeColor: Colors.blue,
//                       inactiveColor: Colors.grey,
//                       selectedColor: Colors.blueAccent,
//                     ),
//                     animationDuration: const Duration(milliseconds: 300),
//                     backgroundColor: Colors.transparent,
//                     enableActiveFill: true,
//                     onCompleted: (value) {
//                       context.read<EmailVerificationCubit>().verifyCode(context, value);
//                     },
//                     onChanged: (value) {},
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: () {
//                       context.read<EmailVerificationCubit>().verifyCode(context, _codeController.text);
//                     },
//                     child: const Text('Verify'),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
//                       textStyle: const TextStyle(fontSize: 16),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   TextButton(
//                     onPressed: () {
//                       // إعادة إرسال الرمز
//                       print('Resend code');
//                     },
//                     child: const Text(
//                       'Resend Code',
//                       style: TextStyle(decoration: TextDecoration.underline),
//                     ),
//                   ),
//                   Spacer(),
//                   Row(
//                     children: [
//                       const Text('Already a member?'),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.of(context).pushNamed(AppRoutes.logInScreen as String);
//                           print('Sign in instead');
//                         },
//                         child: const Text(
//                           'Sign in instead',
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
