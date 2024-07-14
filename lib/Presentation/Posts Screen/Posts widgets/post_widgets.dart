import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Data/Posts_model.dart';
import '../../../Util/api_endpoints.dart';
import '../../../Util/app_routes.dart';
import '../../../Util/cache_helper.dart';
import '../../../Util/global Widgets/animation.dart';
import '../../../Util/network_helper.dart';

//for comments
class PostCard_with_comments extends StatefulWidget {
  final int budget;
  final String description;
  final String? status;
  final String phone;
  final String selectedGovernorate;
  final String selectedArea;
  final String userName;
  final String? userProfileImageUrl;
  final DateTime? postDate;
  final int postId;

  const PostCard_with_comments(
      {super.key,
      required this.budget,
      required this.description,
      this.status,
      required this.phone,
      required this.selectedGovernorate,
      required this.selectedArea,
      required this.userName,
      this.userProfileImageUrl,
      this.postDate,
      required this.postId});

  String formatBudget(int budget) {
    if (budget >= 1000000000) {
      return '${(budget / 1000000000).toStringAsFixed(1)} billion';
    } else if (budget >= 1000000) {
      return '${(budget / 1000000).toStringAsFixed(1)} million sp';
    } else if (budget >= 1000) {
      return '${(budget / 1000).toStringAsFixed(1)} K sp';
    } else {
      return budget.toString();
    }
  }

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard_with_comments> {
  bool showComments = false;
  List<CommentModel> comments = [];
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
    String token = (await CacheHelper.getString(key: 'token'))!;

    var response = await NetworkHelper.get(
      ApiAndEndpoints.getComments + "post_id=${widget.postId}",
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("comments get  ${widget.postId}");
      final responseBody = jsonDecode(response.body);
      print('Response Body: $responseBody');

      if (responseBody is List) {
        setState(() {
          comments = responseBody
              .map((comment) => CommentModel.fromJson(comment))
              .toList();
        });
      } else {
        print('Unexpected response format');
        // Handle unexpected format
      }
    } else {
      // Handle error
      print('Failed to load comments');
    }
  }

  Future<void> _addComment(String comment) async {
    String token = (await CacheHelper.getString(key: 'token'))!;
    if (comment.isNotEmpty) {
      var response = await NetworkHelper.post(
        ApiAndEndpoints.addComment,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
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

  Future<void> _add_Post_Report() async {
    int postid = widget.postId;
    int id = (await CacheHelper.getInt(key: 'id'))!;

    String token = (await CacheHelper.getString(key: 'token'))!;

    var response = await NetworkHelper.post(
      ApiAndEndpoints.reports_post,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: {
        // 'content': comment,
        // 'post_id': widget.postId,
        "reporter_id": id,
        "reportable_type": "post",
        "reportable_id": postid,
        "report": "This is a test report."
      },
    );
    if (response.statusCode == 201) {
      print("reporte successful");
    } else {
      print(response.body);
      print("failed reporte");
      // Handle error
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.userProfileImageUrl!),
                      radius: 20.0,
                    ),
                    SizedBox(width: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat.yMMMd().format(widget.postDate!),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  onSelected: (String value) {
                    if (value == 'report') {
                      print('Report post');
                      int? roleId = CacheHelper.getInt(key: 'role_id');
                      if (roleId == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Text(
                                S.of(context).alert,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(
                                  S.of(context).Please_loginandsignup_broker),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    S.of(context).Log_In,
                                    style: TextStyle(
                                        color: Constants.mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                        MyAnimation.createRoute(
                                            AppRoutes.logInScreen));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else if (roleId == 1) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Text(
                                S.of(context).alert,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              content: Text(S.of(context).Please_subscription),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    S.of(context).Subscription,
                                    style: TextStyle(
                                        color: Constants.mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                        MyAnimation.createRoute(
                                            AppRoutes.subscription));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else if (roleId == 2) {
                        _add_Post_Report();
                      }
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: S.of(context).report,
                        child: Text(S.of(context).Report_post),
                      ),
                    ];
                  },
                  icon: Icon(Icons.expand_more_outlined),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              '${S.of(context).Wanted_for} ${widget.status} ${S.of(context).property_in} ${widget.selectedGovernorate} \n (${widget.selectedArea})',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(Icons.monetization_on_outlined,
                    color: Constants.mainColor),
                SizedBox(width: 5.0),
                Text(
                  '${S.of(context).Budget} ${widget.formatBudget(widget.budget)}',
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
                int? roleId = CacheHelper.getInt(key: 'role_id');
                if (roleId == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                          S.of(context).alert,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content:
                            Text(S.of(context).Please_loginandsignup_broker),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              S.of(context).Log_In,
                              style: TextStyle(
                                  color: Constants.mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                  MyAnimation.createRoute(
                                      AppRoutes.logInScreen));
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (roleId == 1) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                          S.of(context).alert,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text(S.of(context).Please_subscription),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              S.of(context).Subscription,
                              style: TextStyle(
                                  color: Constants.mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                  MyAnimation.createRoute(
                                      AppRoutes.subscription));
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (roleId == 2) {
                  // إجراء مكالمة هاتفية إذا كان المستخدم وسيط
                  final url = 'tel:${widget.phone}';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.phone, color: Constants.mainColor),
                  SizedBox(width: 5.0),
                  Text(
                    S.of(context).Contact,
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
              onTap: () {
                int? roleId = CacheHelper.getInt(key: 'role_id');
                if (roleId == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                          S.of(context).alert,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content:
                            Text(S.of(context).Please_loginandsignup_broker),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              S.of(context).Log_In,
                              style: TextStyle(
                                  color: Constants.mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                  MyAnimation.createRoute(
                                      AppRoutes.logInScreen));
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (roleId == 1) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                          S.of(context).alert,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text(S.of(context).Please_subscription),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              S.of(context).Subscription,
                              style: TextStyle(
                                  color: Constants.mainColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                  MyAnimation.createRoute(
                                      AppRoutes.subscription));
                            },
                          ),
                        ],
                      );
                    },
                  );
                } else if (roleId == 2) {
                  _toggleComments();
                } else {
                  print("Unknown Role ID");
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.comment, color: Constants.mainColor),
                  SizedBox(width: 5.0),
                  Text(
                    S.of(context).Comments,
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  Future<void> _add_Comment_Report() async {
                    int commentid = comments[index].id;
                    int id = (await CacheHelper.getInt(key: 'id'))!;
                    String token = (await CacheHelper.getString(key: 'token'))!;
                    var response = await NetworkHelper.post(
                      ApiAndEndpoints.reports_post,
                      headers: {
                        'Content-Type': 'application/json',
                        'Authorization': 'Bearer $token',
                      },
                      body: {
                        // 'content': comment,
                        // 'post_id': widget.postId,
                        "reporter_id": id,
                        "reportable_type": "comment",
                        "reportable_id": commentid,
                        "report": "This is a test report."
                      },
                    );
                    if (response.statusCode == 201) {
                      print("reporte successful (comment)");
                    } else {
                      print(response.body);
                      print("failed reporte");
                      // Handle error
                    }
                  }

                  ;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(comments[index].userProfileImageUrl),
                          radius: 20.0,
                        ),
                        SizedBox(width: 5.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    comments[index].userName,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  PopupMenuButton<String>(
                                    onSelected: (String result) {
                                      if (result == 'report') {
                                        // تنفيذ إجراء الإبلاغ هنا
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        onTap: _add_Comment_Report,
                                        value: 'report',
                                        child: Text(S.of(context).report),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(comments[index].content),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: commentController,
                decoration: InputDecoration(
                  labelText: S.of(context).Add_comment,
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
//for show my posts
