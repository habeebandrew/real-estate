
import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';

import 'package:url_launcher/url_launcher.dart';

// class CallButton extends StatelessWidget {
//   final String phoneNumber = "1234567890";
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         final url = 'tel:$phoneNumber';
//         if (await canLaunch(url)) {
//           await launch(url);
//         } else {
//           throw 'Could not launch $url';
//         }
//       },
//       child: Row(
//         children: [
//           Icon(Icons.phone, color: Constants.mainColor),
//           SizedBox(width: 5.0),
//           Text('للتواصل', style: TextStyle(fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }
class PostCard extends StatelessWidget {
  final String budget;
  final String description;
  final String timeAgo;

  PostCard({
    required this.budget,
    required this.description,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = "0992093648";
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(15.0),
      shadowColor: Constants.mainColor,
      elevation: 5.0, // ارتفاع الظلة
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مطلوب للإيجار عقار في دمشق',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,
            ),
            SizedBox(height: 5.0),
            Text(
              'الميزانية: $budget',
              style: TextStyle(fontSize: 16, color: Colors.blue[900]),textDirection: TextDirection.ltr,
            ),
            SizedBox(height: 10.0),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () async {
                final url = 'tel:$phoneNumber';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.phone, color: Constants.mainColor),


                  SizedBox(width: 5.0),
                  Text('للتواصل', style: TextStyle(fontSize: 16),textDirection: TextDirection.ltr,),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Divider(),
            // SizedBox(height:/ 5.0),
          ],
        ),
      ),
    );

  }
}