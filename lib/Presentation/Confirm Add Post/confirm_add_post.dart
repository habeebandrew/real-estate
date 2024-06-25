import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pro_2/Util/constants.dart';
import 'dart:convert';
import 'package:pro_2/Util/global%20Widgets/animation.dart';
import '../../../Util/app_routes.dart';
import '../../Bloc/Posts Cubit/posts_cubit.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/mySnackBar.dart';
import '../../Util/global Widgets/my_button.dart';
import '../../Util/network_helper.dart';
import '../Posts Screen/Posts widgets/post_widgets.dart';
class ConfirmAddPost extends StatelessWidget {
  String my_name = (CacheHelper.getString(key: 'name'))!;
final int budget;
  final String description;
  final int phone;
  final String selectedArea;
  final String selectedGovernorate;
  final String status;
   ConfirmAddPost({
    super.key,
    required this.budget,
    required this.description,
    required this.phone,
    required this.selectedArea,
    required this.selectedGovernorate,
    required this.status,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Ad"),
        backgroundColor: Colors.white,
      ),
      body: BlocProvider(
        create: (context) => PostsCubit(),
        child: BlocConsumer<PostsCubit, PostsState>(
          listener: (context, state) {
              if (state is PostFailed) {
              mySnackBar(
                context: context,
                color: Colors.red,
                title: 'Published failed: ${state.error}',
              );
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.homeScreen));
              });
            }
          },
          builder: (context, state) {
            if (state is PostsLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                // post_card_confirm()
                post_card_confirm(budget: budget,selectedGovernorate: selectedGovernorate,status:status
                  ,selectedArea:selectedArea ,phone: phone,description: description,),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyButton(onPreessed: () {
                      Navigator.of(context).push(
                        MyAnimation.createRoute(AppRoutes.addPost),
                      );
                    },tittle: "Edit",
                      minWidth: 100,
                      height: 20,
                    ),
                    MyButton(
                      minWidth: 100,
                      height: 20, tittle: 'Post', onPreessed: () {
                      context.read<PostsCubit>().postData(context,
                        budget: budget,
                        description: description,
                        phone: phone,
                        selectedArea: selectedArea,
                        selectedGovernorate: selectedGovernorate,
                        status: status,
                      ); },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}