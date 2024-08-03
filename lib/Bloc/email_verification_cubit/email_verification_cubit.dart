// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:pro_2/Bloc/email_verification_cubit/email_verification_service.dart';
// import 'package:pro_2/Util/cache_helper.dart';
// import 'package:pro_2/Util/global Widgets/mySnackBar.dart';
//
// import '../../Data/user_model.dart';
// import '../../Util/app_routes.dart';
//
// part 'email_verification_state.dart';
//
// class EmailVerificationCubit extends Cubit<EmailVerificationState> {
//   EmailVerificationCubit() : super(EmailVerificationInitial());
//
//   Future<void> verifyCode(BuildContext context, String code) async {
//     emit(EmailVerificationLoading());
//
//     String? userName = await CacheHelper.getString(key: 'user_name_verify');
//     if (userName == null) {
//       emit(EmailVerificationFailure('Error: user_name_verify is null'));
//       return;
//     }
//
//     try {
//       User? user = await EmailVerificationService.verifyCode(
//         userName: userName,
//         code: code,
//       );
//
//       if (user != null) {
//         emit(EmailVerificationSuccess(user));
//
//         // تخزين البيانات في التخزين المؤقت
//         await CacheHelper.putString(key: 'name', value: user.user.username);
//         await CacheHelper.putInt(key: 'role_id', value: user.user.roleId);
//         await CacheHelper.putInt(key: 'id', value: user.user.id);
//         await CacheHelper.putString(key: 'image', value: user.image);
//         await CacheHelper.putString(key: 'token', value: user.accessToken);
//
//         try {
//           await CacheHelper.putString(key: 'number', value: user.number ?? '');
//         } catch (e) {
//           print(e);
//           await CacheHelper.putString(key: 'number', value: '');
//         }
//
//         // عرض رسالة نجاح والتبديل إلى الشاشة الرئيسية
//         mySnackBar(
//           context: context,
//           title: 'Verification successful',
//         );
//
//         Future.delayed(const Duration(seconds: 2), () {
//           Navigator.of(context).pushNamed(AppRoutes.homeScreen as String);
//         });
//       } else {
//         emit(EmailVerificationFailure('Invalid code or verification failed.'));
//       }
//     } catch (e) {
//       emit(EmailVerificationFailure('Exception: $e'));
//     }
//   }
// }
