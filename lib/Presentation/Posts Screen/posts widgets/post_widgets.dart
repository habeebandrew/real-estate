
import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';


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
    return Card(color: Constants.mainColor4,
      margin: EdgeInsets.all(15.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مطلوب للإيجار عقار في دمشق',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(
              'الميزانية: $budget',
              style: TextStyle(fontSize: 16, color: Colors.blue[900]),
            ),
            SizedBox(height: 10.0),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone, color: Constants.mainColor),
                    SizedBox(width: 5.0),
                    Text('للتواصل', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Text(timeAgo, style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            SizedBox(height: 10.0),
            Divider(),
            SizedBox(height: 10.0),
            // TextField(
            //   decoration: InputDecoration(
            //     border: OutlineInputBorder(),
            //     labelText: 'اكتب تعليقك هنا...',
            //   ),
            // ),
            // SizedBox(height: 10.0),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     child: Text('إرسال'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}