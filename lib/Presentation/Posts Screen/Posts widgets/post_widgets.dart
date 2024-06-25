
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Util/api_endpoints.dart';
import '../../../Util/cache_helper.dart';
import 'package:http/http.dart' as http;

import '../../../Util/network_helper.dart';

class post_card extends StatelessWidget {
  final int budget;
   int?  id;
  final String description;
   String? status;
  final int  phone;
  final String  selectedGovernorate;
  final String  selectedArea;
  final String userName;
   String? userProfileImageUrl;
   DateTime? postDate;//DateTime

  post_card({
    required this.budget,
     this.id,
    required this.description,
     this.status,
    required this.phone,
    required this.selectedGovernorate,
    required this.userName,
     this.userProfileImageUrl,
     this.postDate,
    required this.selectedArea,

  });
  String formatBudget(int budget) {
    if (budget >= 1000000000) {
      return '${(budget / 1000000000).toStringAsFixed(1)} billion';
    } else if (budget >= 1000000) {
      return '${(budget / 1000000).toStringAsFixed(1)} million sp';
    } else if (budget >= 1000) {
      return '${(budget / 1000).toStringAsFixed(1)} K sp';
    }else {
      return budget.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
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
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userProfileImageUrl!),
                  radius: 20.0,
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat.yMMMd().format(postDate!),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Wanted for $status property in $selectedGovernorate _ $selectedArea',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // textDirection: TextDirection.LTR,
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.monetization_on_outlined, color: Constants.mainColor,),
                SizedBox(width: 5.0),
                Text(
                  'Budget: ${formatBudget(budget)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Constants.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  // textDirection: TextDirection.ltr,
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              description,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20.0),
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
                children: [Text("$id"),//for del just test here !!!
                  Icon(Icons.phone, color:Constants.mainColor,),
                  SizedBox(width: 5.0),
                  Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 16,
                      color:Constants.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                    // textDirection: TextDirection.ltr,
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
//for confirm
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
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(""),//حط صورتي الشخصية
                  radius: 20.0,
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
            Text(
              'Wanted for $status properity in $selectedGovernorate _ $selectedArea',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              // textDirection: TextDirection.LTR,
            ),
            SizedBox(height: 5.0),
            Row(
              children: [Icon(Icons.monetization_on_outlined,color: Constants.mainColor,),SizedBox(width: 5,),
                Text(
                  'budget: ${formatBudget(budget)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Constants.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  // textDirection: TextDirection.ltr,
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
                  Text('Contact', style: TextStyle(fontSize: 16,color: Constants.mainColor,fontWeight: FontWeight.bold),
                    // textDirection: TextDirection.ltr
                    ),
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

//for comments
class PostCard_with_comments extends StatefulWidget {
  final int budget;
  final String description;
  final String? status;
  final int phone;
  final String selectedGovernorate;
  final String selectedArea;
  final String userName;
  final String? userProfileImageUrl;
  final DateTime? postDate;
  final int postId;

  const PostCard_with_comments({super.key, required this.budget, required this.description,
    this.status, required this.phone, required this.selectedGovernorate, required this.selectedArea,
    required this.userName, this.userProfileImageUrl, this.postDate, required this.postId});

  String formatBudget(int budget) {
    if (budget >= 1000000000) {
      return '${(budget / 1000000000).toStringAsFixed(1)} billion';
    } else if (budget >= 1000000) {
      return '${(budget / 1000000).toStringAsFixed(1)} million sp';
    }
    else if (budget >= 1000) {
      return '${(budget / 1000).toStringAsFixed(1)} K sp';
    }
    else {
      return budget.toString();
    }
  }

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard_with_comments> {
  bool showComments = false;
  List<String> comments = [];
  final TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  void _toggleComments() {
    setState(() {
      showComments = !showComments;
    });
  }

  Future<void> _fetchComments() async {
    final response = await http.get(Uri.parse('https://yourapi.com/getComment?post_id=${widget.postId}'));
    if (response.statusCode == 200) {
      final List<dynamic> commentList = jsonDecode(response.body);
      setState(() {
        comments = commentList.map((comment) => comment['content'] as String).toList();
      });
    } else {
      // Handle error
    }
  }

  Future<void> _addComment(String comment) async {
    String token = (await CacheHelper.getString(key: 'token'))!;
    if (comment.isNotEmpty) {
      var response = await NetworkHelper.post(
        ApiAndEndpoints.addComment , headers: {'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },  body: {
        'content': comment,
        'post_id': widget.postId,
      },
      );
      if (response.statusCode == 201) {
        print("trueeee");
        // Comment added successfully, refresh comments
        _fetchComments();
        commentController.clear();
      } else {
        // Handle error
      }
    }
  }
  @override
  Widget build(BuildContext context) {
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
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.userProfileImageUrl!),
                  radius: 20.0,
                ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userName,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat.yMMMd().format(widget.postDate!),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              'Wanted for ${widget.status} property in ${widget.selectedGovernorate} - ${widget.selectedArea}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.monetization_on_outlined, color: Constants.mainColor),
                SizedBox(width: 5.0),
                Text(
                  'Budget: ${widget.formatBudget(widget.budget)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Constants.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              widget.description,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              onTap: () async {
                final url = 'tel:${widget.phone}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.phone, color: Constants.mainColor),
                  SizedBox(width: 5.0),
                  Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 16,
                      color: Constants.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Divider(),
            GestureDetector(
              onTap: _toggleComments,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.comment, color: Constants.mainColor),
                  SizedBox(width: 5.0),
                  Text(
                    'Comments',
                    style: TextStyle(
                      fontSize: 16,
                      color: Constants.mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            if (showComments) ...[
              SizedBox(height: 10.0),
              for (var comment in comments) Text(comment),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  labelText: 'Add a comment...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _addComment(commentController.text),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
