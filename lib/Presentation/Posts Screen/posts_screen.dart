import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/animation.dart';
import 'Posts widgets/post_widgets.dart';


class PostsScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}
class _PostScreenState extends State<PostsScreen> {
  List<Post> posts = [];
  void fetchPosts() async {
    // String token = (await CacheHelper.getString(key: 'token'))!;
    final response = await http.get(
      Uri.parse(ApiAndEndpoints.api+ApiAndEndpoints.getpost),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['posts'];
      setState(() {
        posts = data.map((postJson) => Post.fromJson(postJson)).toList();
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }
  @override
  void initState() {
    super.initState();
    fetchPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: TextButton(onPressed: (){
          Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.addPost));

        },child: Text("+ add my ad"),)
      ),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var post = posts[index];
          return
            post_card(description:post.description ,phone: post.mobilenumber,
              selectedArea: post.region,status:post.state
              ,selectedGovernorate: post.governorate,budget: post.budget,postDate:post.createdAt,
              userName: post.userId,userProfileImageUrl: post.profileImage,);
        },
      ),
    );
  }
}
//Model
class Post {
  final int id;
  final String userId;
  final String state;
  final String governorate;
  final String region;
  final int budget;
  final String description;
  final int mobilenumber;
  final String profileImage;
  final DateTime createdAt;
  Post({
    required this.id,
    required this.userId,
    required this.state,
    required this.governorate,
    required this.region,
    required this.budget,
    required this.description,
    required this.mobilenumber,
    required this.profileImage,
    required this.createdAt,
  });
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user_id'],
      state: json['state'],
      governorate: json['governorate'],
      region: json['region'],
      budget: json['budget'],
        description: json['description'],
      mobilenumber: json['mobilenumber'],
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
