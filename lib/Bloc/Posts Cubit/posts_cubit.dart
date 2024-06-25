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
