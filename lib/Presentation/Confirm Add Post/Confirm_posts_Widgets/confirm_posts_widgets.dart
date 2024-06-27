



import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Util/cache_helper.dart';
import '../../../Util/constants.dart';

class post_card_confirm extends StatelessWidget {
  String name = (CacheHelper.getString(key: 'name'))!;
  final int budget;
  final String description;
  final String status;
  final int  phone;
  final String  selectedGovernorate;
  final String  selectedArea;
  post_card_confirm({
    required this.budget,
    required this.description,
    required this.status,
    required this.phone,
    required this.selectedGovernorate,
    required this.selectedArea,
  });
  String formatBudget(int budget) {
    if (budget >= 1000000000) {
      return '${(budget / 1000000000).toStringAsFixed(1)} billion';
    } else if (budget >= 1000000) {
      return '${(budget / 1000000).toStringAsFixed(1)} million sp';
    } else {
      return budget.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    String? image=CacheHelper.getString(key: 'image');

  return Card(
      color: Colors.white,
      margin: EdgeInsets.all(15.0),
      shadowColor: Constants.mainColor,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
        image != null?
            CircleAvatar(
            backgroundImage:
            NetworkImage(image!),
        radius: 20.0,
        backgroundColor: Colors.white,
      ):
      CircleAvatar(
      backgroundImage:
      AssetImage("assets/images/General/App_Icon.png"),
    radius: 40.0,
    backgroundColor: Colors.white,
    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Now",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),

              ],
            ),
            Text(
              'Wanted for $status properity in $selectedGovernorate _ $selectedArea',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.monetization_on_outlined, color: Constants.mainColor,),
                SizedBox(width: 5),
                Text(
                  'budget: ${formatBudget(budget)}',
                  style: TextStyle(
                    fontSize: 16,
                    color:Constants.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.phone, color: Constants.mainColor,),
                  SizedBox(width: 5.0),
                  Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 16,
                      color:Constants.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Divider(),
          ],
        ),
      ),
    );
  }
}
