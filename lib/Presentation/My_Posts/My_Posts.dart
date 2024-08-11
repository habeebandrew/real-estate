import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/generated/l10n.dart';
import '../../Data/Posts_model.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/cache_helper.dart';
import 'MY_Posts_Widgets/myposts_widgets.dart';

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
    String api = await ApiAndEndpoints.api; // انتظار قيمة الـ api هنا

    final response = await http.get(
      Uri.parse(api + ApiAndEndpoints.get_My_Post),
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
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(S.of(context).My_posts),
          backgroundColor: Constants.mainColor2,
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : posts.isEmpty
            ? Center(
            child: Text(S.of(context).There_are_no_posts,
                style: const TextStyle(fontSize: 18)))
            : ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
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
            }));
  }
}
