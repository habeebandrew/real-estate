import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';

import '../../../Util/app_routes.dart';
import '../../../Util/global Widgets/animation.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  // final String imageUrl; // رابط الصورة

  ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    // required this.imageUrl,

  });

  void _onCardTapped(BuildContext context) {
    // // هنا ضع العملية التي تريد تنفيذها عند الضغط على الكارد
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('تم النقر على البطاقة!')),
    // );
    Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.showsharing));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 8,
      shadowColor: Colors.black26,
      child: InkWell(
        onTap:(){    Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.showsharing));
        },// () => _onCardTapped(context), // استدعاء الوظيفة عند الضغط
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                "assets/images/Onboarding/1.png",
                // height: 150.0,
                height: 250,
                width: 400,
                // width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Icon(icon, size: 40.0, color: Constants.mainColor),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}