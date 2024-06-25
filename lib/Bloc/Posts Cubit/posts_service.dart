// import '../../Data/user_model.dart';
// import '../../Util/api_endpoints.dart';
// import '../../Util/network_helper.dart';
//
// class PostsService {
//   static Future<Map<String, dynamic>> addPost({
//     required String governorate,
//     required String state,
//     required String region,
//     required int budget,
//     required String description,
//     required int mobileNumber,
//   }) async {
//     var response = await NetworkHelper.post(
//       ApiAndEndpoints.createpost,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: {
//         "state": state,
//         "governorate": governorate,
//         "region": region,
//         "budget": budget,
//         "description": description,
//         "mobileNumber": mobileNumber,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       try {
//         var user = userFromJson(response.body);
//         return {'status': true, 'data': user};
//       } catch (e) {
//         return {'status': false, 'error': 'Failed to parse JSON: $e'};
//       }
//     } else {
//       return {'status': false, 'error': 'Failed to register. HTTP status: ${response.statusCode}'};
//     }
//   }
// }
