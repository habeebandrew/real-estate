
import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';

import 'package:url_launcher/url_launcher.dart';

class post_card extends StatelessWidget {
  final int budget;
  final String description;
  final String status;
  final int  phone;
  final String  selectedGovernorate;
  final String  selectedArea;

  post_card({
    required this.budget,
    required this.description,
    required this.status,
    required this.phone,
    required this.selectedGovernorate,

    required this.selectedArea,

  });

  @override
  Widget build(BuildContext context) {
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
              'Wanted for $status properity in $selectedGovernorate _ $selectedArea',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,
            ),
            SizedBox(height: 5.0),
            Row(
              children: [Icon(Icons.monetization_on_outlined,color: Constants.mainColor,),SizedBox(width: 5,),
                Text(
                  'budget: $budget',
                  style: TextStyle(fontSize: 16, color: Constants.mainColor,fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              description,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final url = 'tel:$phone';
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
                  Text('Contact', style: TextStyle(fontSize: 16,color: Constants.mainColor,fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,),
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
              'Wanted for buy properity in Damascus',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,
            ),
            SizedBox(height: 5.0),
            Row(
              children: [Icon(Icons.monetization_on_outlined,color: Constants.mainColor,),SizedBox(width: 5,),
                Text(
                  'budget: $budget',
                  style: TextStyle(fontSize: 16, color: Constants.mainColor,fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              description,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
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
                  Text('Contact', style: TextStyle(fontSize: 16,color: Constants.mainColor,fontWeight: FontWeight.bold),textDirection: TextDirection.ltr,),
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