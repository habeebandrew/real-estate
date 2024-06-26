import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../../Data/Posts_model.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/dimensions.dart';
import 'Posts widgets/post_widgets.dart';
class PostsScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}
class _PostScreenState extends State<PostsScreen> {
  List<Post> posts = [];
  List<Post> filteredPosts = [];
  bool _isLoading = true;
  String selectedState = 'All'; // 'All', 'For Sale', 'For Rent'
  String selectedGovernorate = 'All Cities'; // 'All' or specific governorate
  String selectedSortOrder = 'Newest'; // 'Newest', 'Oldest'
  String selectedRegion = 'All';
  void fetchPosts() async {
    final response = await http.get(
      Uri.parse(ApiAndEndpoints.api + ApiAndEndpoints.getpost),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['posts'];
      setState(() {
        posts = data.map((postJson) => Post.fromJson(postJson)).toList();
        applyFilters();
      });
    } else {
      throw Exception('Failed to load posts');
    }
  }
  void applyFilters() {
    setState(() {
      filteredPosts = posts.where((post) {
        bool matchesState = selectedState == 'All' || post.state == selectedState;
        bool matchesGovernorate =
            selectedGovernorate == 'All Cities' || post.governorate == selectedGovernorate;
        bool matchesRegion = selectedRegion == 'All' || post.region == selectedRegion;
        return matchesState && matchesGovernorate  && matchesRegion;
      }).toList();

      if (selectedSortOrder == 'Newest') {
        filteredPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else {
        filteredPosts.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }
    });
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
      appBar:PreferredSize(
    preferredSize: Size.fromHeight(30.0), // تعديل ارتفاع الـ AppBar هنا
    child: AppBar(backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:
        Row(
          children: [
            SizedBox(width: Dimensions.widthPercentage(context, 16),
              child: Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedState,
                    isExpanded: true,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    items: ['All', 'buy', 'rental']
                        .map((state) => DropdownMenuItem<String>(
                      value: state,
                      child: Text(state),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedState = value!;
                        applyFilters();
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width:Dimensions.widthPercentage(context, 3),),
            // SizedBox(width: 8),
            SizedBox(width: Dimensions.widthPercentage(context, 25),
              child: Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedGovernorate,
                    isExpanded: true,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    items: [
                      'All Cities',
                      'Damascus',
                      'Rural Damascus',
                      'Aleppo',
                      'Rural Aleppo',
                      'Homs',
                      'Rural Homs',
                      'Latakia',
                      'Rural Latakia',
                      'Tartous',
                      'Rural Tartous',
                      'Hama',
                      'Rural Hama',
                      'Idlib',
                      'Rural Idlib',
                      'Deir ez-Zor',
                      'Rural Deir ez-Zor',
                      'Raqqa',
                      'Rural Raqqa',
                      'Al-Hasakah',
                      'Rural Al-Hasakah',
                      'Daraa',
                      'Rural Daraa',
                      'As-Suwayda',
                      'Rural As-Suwayda',
                      'Quneitra',
                      'Rural Quneitra'
                    ]
                        .map((governorate) => DropdownMenuItem<String>(
                      value: governorate,
                      child: Text(governorate),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGovernorate = value!;
                        applyFilters();
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: Dimensions.widthPercentage(context, 3),),
            SizedBox(width: Dimensions.widthPercentage(context, 22),
              child: Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSortOrder,
                    isExpanded: true,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    items: ['Newest', 'Oldest']
                        .map((order) => DropdownMenuItem<String>(
                      value: order,
                      child: Text(order),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedSortOrder = value!;
                        applyFilters();
                      });
                    },
                  ),
                ),
              ),
            ),
            Spacer(),

            Text('Posts: ${filteredPosts.length}',style: TextStyle(fontSize: 12),),
            // Spacer(),
            // SizedBox(width:  Dimensions.widthPercentage(context, 10),
            //   child: IconButton(
            //     icon: Icon(Icons.filter_list),
            //     onPressed: (){},
            //     color: Colors.black,
            //   ),
            // ),
          ],
        ),

      ),),
      body:
      _isLoading
          ? Center(child: CircularProgressIndicator())
          : filteredPosts.isEmpty
          ? Center(child: Text('There is no data', style: TextStyle(fontSize: 18)))
          : ListView.builder(
        itemCount: filteredPosts.length,
        itemBuilder: (context, index) {
          var post = filteredPosts[index];
          return PostCard_with_comments(
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
        },
      ),
    );
  }
}



