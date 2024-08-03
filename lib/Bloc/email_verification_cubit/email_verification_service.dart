// import 'dart:convert';
// import 'package:pro_2/Util/api_endpoints.dart';
// import 'package:pro_2/Util/network_helper.dart';
// import '../../Data/user_model.dart';
//
// class EmailVerificationService {
//   static Future<User?> verifyCode({
//     required String userName,
//     required String code,
//   }) async {
//     var response = await NetworkHelper.post(
//       ApiAndEndpoints.verify,
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//       },
//       body: jsonEncode({
//         'user_name': "$userName",
//         'code': "${code.toString()}",
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       try {
//         var responseData = jsonDecode(response.body);
//
//         if (responseData is Map<String, dynamic> && responseData.containsKey('user')) {
//           // Parse the user data
//           return User.fromJson(responseData);
//         } else if (responseData is List) {
//           // Handle the case where responseData is a list of messages
//           print('Response message: ${responseData.join(', ')}');
//           return null;
//         } else {
//           print('Unexpected response format: ${responseData}');
//           return null;
//         }
//       } catch (e) {
//         print('Failed to parse JSON: $e');
//         return null;
//       }
//     } else {
//       print('Failed to verify code. HTTP status: ${response.statusCode}');
//       return null;
//     }
//   }
// }
