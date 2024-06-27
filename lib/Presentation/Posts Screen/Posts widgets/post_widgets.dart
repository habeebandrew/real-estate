import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Data/Posts_model.dart';
import '../../../Util/api_endpoints.dart';
import '../../../Util/app_routes.dart';
import '../../../Util/cache_helper.dart';
import '../../../Util/global Widgets/animation.dart';
import '../../../Util/network_helper.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(""), // حط صورتي الشخصية
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
    }else {
      // Handle error
      print('Failed to load comments');
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                'alert',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                              content: Text('You do not have permission to report posts. Please log in and sign up as a broker!!'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
   else if (roleId == 1) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Text(
                                'alert',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                              content: Text('You do not have permission to to report posts. Please subscription as a broker!!'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Subscription',
                                    style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.subscription));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'report',
                        child: Text('Report the post'),
                      ),
                    ];
                  },
                  icon: Icon(Icons.expand_more_outlined),
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
    int? roleId = CacheHelper.getInt(key: 'role_id');
    if (roleId == null) {  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'alert',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Text('You do not have permission to see the phone number. Please log in and sign up as a broker!!'),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Log In',
                style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
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
              'alert',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            content: Text('You do not have permission to see the phone number. Please subscription as a broker!!'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Subscription',
                  style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.subscription));
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
    } },
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
              onTap:  () {
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
                          'alert',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text('You do not have permission to see comments. Please log in and sign up as a broker!!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Log In',
                              style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
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
                          'alert',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text('You do not have permission to see comments,Please subscription as a broker!!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Subscription',
                              style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.subscription));
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              comments[index].userProfileImageUrl
                          ),
                          radius: 20.0,
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comments[index].userName,
                              // "habeeb",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.0),
                            Text(comments[index].content),
                          ],
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
//for show my posts

class PostCard_MYPOSTS extends StatefulWidget {
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

  const PostCard_MYPOSTS({super.key, required this.budget, required this.description,
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
  PostCard createState() => PostCard();
}
class PostCard extends State<PostCard_MYPOSTS> {
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
      if (responseBody is Map && responseBody['comments'] is List) {
        setState(() {
          comments = (responseBody['comments'] as List)
              .map((comment) => CommentModel.fromJson(comment).content)
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                'alert',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                              content: Text('You do not have permission to report posts. Please log in and sign up as a broker!!'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Log In',
                                    style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else if (roleId == 1) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Text(
                                'alert',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                              content: Text('You do not have permission to to report posts. Please subscription as a broker!!'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    'Subscription',
                                    style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.subscription));
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'report',
                        child: Text('Report the post'),
                      ),
                    ];
                  },
                  icon: Icon(Icons.expand_more_outlined),
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
                int? roleId = CacheHelper.getInt(key: 'role_id');
                if (roleId == null) {  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      title: Text(
                        'alert',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      content: Text('You do not have permission to see the phone number. Please log in and sign up as a broker!!'),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            'Log In',
                            style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
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
                          'alert',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text('You do not have permission to see the phone number. Please subscription as a broker!!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Subscription',
                              style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.subscription));
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
                } },
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
              onTap:  () {
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
                          'alert',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text('You do not have permission to see comments. Please log in and sign up as a broker!!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Log In',
                              style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
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
                          'alert',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text('You do not have permission to see comments,Please subscription as a broker!!'),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'Subscription',
                              style: TextStyle(color: Constants.mainColor,fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.subscription));
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(""
                            // comments[index].userProfileImageUrl
                          ),
                          radius: 20.0,
                        ),
                        SizedBox(width: 10.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // comments[index].userName,
                              "habeeb",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4.0),
                            Text(comments[index]),
                          ],
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
