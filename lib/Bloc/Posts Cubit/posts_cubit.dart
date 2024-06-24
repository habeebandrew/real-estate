import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Posts%20Cubit/posts_service.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/animation.dart';
import '../../Util/global Widgets/mySnackBar.dart';
import '../../Util/network_helper.dart';
part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);
  void pressed() {
    emit(PostsLoadingState());
    print("iam in posts");
  }

  // Function to post data
  Future<void> postData(BuildContext context,{
    required int budget,
    required String description,
    required int phone,
    required String selectedArea,
    required String selectedGovernorate,
    required String status,
  }) async {
    emit(PostsLoadingState());

    try {
      String token = (await CacheHelper.getString(key: 'token'))!;
      var response = await NetworkHelper.post(
        ApiAndEndpoints.createpost,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "state": status,
          "governorate": selectedGovernorate,
          "region": selectedArea,
          "budget": budget.toString(),
          "description": description,
          "mobilenumber": phone.toString(),
        },
      );

      if (response.statusCode == 200) {
        emit(PostSuccess(response.body));
        mySnackBar(
          context: context,
          title: 'Published successful',
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.homeScreen));
        });
      } else {
        emit(PostFailed(response.statusCode, response.body));
      }
    } catch (e) {
      emit(PostFailed(0, e.toString()));
    }
  }
}







//
// class PostsCubit extends Cubit<PostsState> {
//   PostsCubit() : super(PostsInitialState());
//
//   static PostsCubit get(context) => BlocProvider.of(context);
//
//   String State = "";
//   String? selectedGovernorate = 'دمشق';
//   String? selectedArea = 'المزة';
//   TextEditingController budgetController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//
//   void resetFormFields() {
//     budgetController.clear();
//     descriptionController.clear();
//     phoneController.clear();
//     selectedGovernorate = 'دمشق';
//     selectedArea = 'المزة';
//   }
//
//   void addPost(BuildContext context) async {
//     // if (logInFormKey.currentState!.validate()) { ساوي فاليديشن الهها
//     emit(PostsLoadingState());
//     var response = await PostsService.addPost(
//       governorate: selectedGovernorate!,
//       state: State,
//       region: selectedArea!,
//       budget: int.parse(budgetController.text),
//       description: descriptionController.text,
//       mobileNumber: int.parse(phoneController.text),
//     );
//
//     if (response['status']) {
//       emit(PostsLoadedState());
//       mySnackBar(
//         context: context,
//         title: 'My ad was published successfully',
//       );
//       resetFormFields();
//       Future.delayed(const Duration(seconds: 2), () {
//         Navigator.of(context).push(
//             MyAnimation.createRoute(AppRoutes.homeScreen));
//       });
//     } else {
//       resetFormFields();
//       emit(PostsErrorState(message: response['error']));
//     }
//     // }
//   }
//
//   void pressed() {
//     emit(PostsLoadedState());
//     print("iam in posts");
//   }
// // }
// }
