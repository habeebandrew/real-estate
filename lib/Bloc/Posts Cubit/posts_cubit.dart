import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_2/Bloc/Posts%20Cubit/posts_service.dart';

import '../../Util/app_routes.dart';
import '../../Util/global Widgets/animation.dart';
import '../../Util/global Widgets/mySnackBar.dart';


part 'posts_state.dart';
//
class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitialState());

  static PostsCubit get(context) => BlocProvider.of(context);

  String State = "";
  String? selectedGovernorate = 'دمشق';
  String? selectedArea = 'المزة';
  TextEditingController budgetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void resetFormFields() {
    budgetController.clear();
    descriptionController.clear();
    phoneController.clear();
    selectedGovernorate = 'دمشق';
    selectedArea = 'المزة';
  }

  void addPost(BuildContext context) async {
    // if (logInFormKey.currentState!.validate()) { ساوي فاليديشن الهها
    emit(PostsLoadingState());
    var response = await PostsService.addPost(
      governorate: selectedGovernorate!,
      state: State,
      region: selectedArea!,
      budget: int.parse(budgetController.text),
      description: descriptionController.text,
      mobileNumber: int.parse(phoneController.text),
    );

    if (response['status']) {
      emit(PostsLoadedState());
      mySnackBar(
        context: context,
        title: 'My ad was published successfully',
      );
      resetFormFields();
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).push(
            MyAnimation.createRoute(AppRoutes.homeScreen));
      });
    } else {
      resetFormFields();
      emit(PostsErrorState(message: response['error']));
    }
    // }
  }

  void pressed() {
    emit(PostsLoadedState());
    print("iam in posts");
  }
// }
}