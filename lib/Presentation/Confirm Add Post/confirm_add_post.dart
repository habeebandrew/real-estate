import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Posts%20Screen/posts%20widgets/post_widgets.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/animation.dart';
import '../../../Util/app_routes.dart';

class ConfirmAddPost extends StatelessWidget {
  const ConfirmAddPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Ads"),
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
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MyAnimation.createRoute(AppRoutes.addPost));
                },
                child: Text('Edit'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.mainColor4),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.addpost2));
                },
                child: Text('Post'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Constants.mainColor2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
