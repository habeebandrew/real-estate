


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Data/Posts_model.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/animation.dart';
import '../../Util/network_helper.dart';
import '../Posts Screen/Posts widgets/post_widgets.dart';

class My_Posts extends StatefulWidget {

  const My_Posts({super.key});

  @override
  State<My_Posts> createState() => _My_PostsState();
}

class _My_PostsState extends State<My_Posts> {
  List<Post> posts = [];
  bool _isLoading = true;

  void fetchPosts() async {
    String token = (await CacheHelper.getString(key: 'token'))!;
    final response = await http.get(
      Uri.parse(ApiAndEndpoints.api + ApiAndEndpoints.get_My_Post),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
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
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
appBar: AppBar(title: Text("My Posts"),backgroundColor: Constants.mainColor2,),
body:_isLoading?
      Center(child: CircularProgressIndicator(),)
    :posts.isEmpty
    ?Center(child: Text('There are no posts published previously !'
    , style: TextStyle(fontSize: 18)))
    :ListView.builder(itemCount: posts.length,itemBuilder:(context, index){
      var post = posts[index];
    return PostCard_MYPOSTS(
      description: post.description,
      phone: post.mobilenumber,
      selectedArea: post.region,
      status: post.state,
      selectedGovernorate: post.governorate,
      budget: post.budget,
      postDate: post.createdAt,
      userName: post.userId,
      userProfileImageUrl: post.profileImage,
      postId: post.id,
    );
    } )
    );
  }
}

