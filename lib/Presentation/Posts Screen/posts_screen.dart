import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/dimensions.dart';
import '../../Util/global Widgets/animation.dart';
import 'Posts widgets/post_widgets.dart';

//
// class PostsScreen extends StatefulWidget {
//   @override
//   _PostScreenState createState() => _PostScreenState();
// }
// class _PostScreenState extends State<PostsScreen> {
//   List<Post> posts = [];
//   void fetchPosts() async {
//     // String token = (await CacheHelper.getString(key: 'token'))!;
//     final response = await http.get(
//       Uri.parse(ApiAndEndpoints.api+ApiAndEndpoints.getpost),
//       headers: {
//         'Content-Type': 'application/json',
//         // 'Authorization': 'Bearer $token',
//       },
//     );
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body)['posts'];
//       setState(() {
//         posts = data.map((postJson) => Post.fromJson(postJson)).toList();
//       });
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }
//   @override
//   void initState() {
//     super.initState();
//     fetchPosts();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(automaticallyImplyLeading: false,
//         title: TextButton(onPressed: (){
//           Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.addPost));
//
//         },child: Text("+ add my ad"),)
//       ),
//       body: posts.isEmpty
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//         itemCount: posts.length,
//         itemBuilder: (context, index) {
//           var post = posts[index];
//           return
//             // post_card(description:post.description ,phone: post.mobilenumber,
//             //   selectedArea: post.region,status:post.state
//             //   ,selectedGovernorate: post.governorate,budget: post.budget,postDate:post.createdAt,
//             //   userName: post.userId,userProfileImageUrl: post.profileImage,id: post.id,);
//           PostCard_with_comments(description:post.description ,phone: post.mobilenumber,
//              selectedArea: post.region,status:post.state
//               ,selectedGovernorate: post.governorate,budget: post.budget,postDate:post.createdAt,
//               userName: post.userId,userProfileImageUrl: post.profileImage,postId: post.id);
//         },
//       ),
//     );
//   }
// }
//test with filter

class PostsScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostsScreen> {
  List<Post> posts = [];
  List<Post> filteredPosts = [];
  String selectedState = 'All'; // 'All', 'For Sale', 'For Rent'
  String selectedGovernorate = 'All Cities'; // 'All' or specific governorate
  String selectedSortOrder = 'Newest'; // 'Newest', 'Oldest'
  double minBudget = 0;
  double maxBudget = 10000000000000;
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
        bool matchesGovernorate = selectedGovernorate == 'All Cities' || post.governorate == selectedGovernorate;
        bool matchesBudget = post.budget >= minBudget && post.budget <= maxBudget;
        bool matchesRegion = selectedRegion == 'All' || post.region == selectedRegion;
        return matchesState && matchesGovernorate && matchesBudget && matchesRegion;
      }).toList();
      if (selectedSortOrder == 'Newest') {
        filteredPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else {
        filteredPosts.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }
    });
  }
  void showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        double tempMinBudget = minBudget;
        double tempMaxBudget = maxBudget;
        String tempSelectedRegion = selectedRegion;

        return AlertDialog(
          title: Text('Filters'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Budget Range'),
              RangeSlider(
                values: RangeValues(tempMinBudget, tempMaxBudget),
                min: 0,
                max: 10000000000000,
                divisions: 100,
                labels: RangeLabels(
                  tempMinBudget.toString(),
                  tempMaxBudget.toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    tempMinBudget = values.start;
                    tempMaxBudget = values.end;
                  });
                },
              ),
              DropdownButton<String>(
                value: tempSelectedRegion,
                items: ['All', 'Region1', 'Region2'] // Add your regions here
                    .map((region) => DropdownMenuItem<String>(
                  value: region,
                  child: Text(region),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    tempSelectedRegion = value!;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  minBudget = tempMinBudget;
                  maxBudget = tempMaxBudget;
                  selectedRegion = tempSelectedRegion;
                  applyFilters();
                });
                Navigator.of(context).pop();
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
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
            SizedBox(width: Dimensions.widthPercentage(context, 15),
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
            SizedBox(width:Dimensions.widthPercentage(context, 5),),
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
            SizedBox(width: Dimensions.widthPercentage(context, 5),),
            SizedBox(width: Dimensions.widthPercentage(context, 20),
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
            Text('Posts: ${filteredPosts.length}',style: TextStyle(fontSize: 8),),





            Spacer(),
            SizedBox(width:  Dimensions.widthPercentage(context, 10),
              child: IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: showFilterDialog,
                color: Colors.black,
              ),
            ),
          ],
        ),

      ),),
      body:
      filteredPosts.isEmpty
          ? Center(child: CircularProgressIndicator())
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
