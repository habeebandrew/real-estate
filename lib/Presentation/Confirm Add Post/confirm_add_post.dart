import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Posts%20Screen/posts%20widgets/post_widgets.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/animation.dart';
import '../../../Util/app_routes.dart';
import '../../Util/global Widgets/my_button.dart';

class ConfirmAddPost extends StatelessWidget {
  const ConfirmAddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Ad"),
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          PostCard(
            budget: "15000000",
            description: "مطلوب منزل للشراء في دمشق ويفضل كسوة ديلوكس",
            timeAgo: "asd",
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              MyButton(tittle: "Edit", onPreessed: (){ Navigator.of(context)
                  .push(MyAnimation.createRoute(AppRoutes.addPost));}, minWidth: 100, height: 20),

              MyButton(tittle: "Post", onPreessed: (){print("Post -->");}, minWidth: 100, height: 20),


            ],
          ),
        ],
      ),
    );
  }
}
