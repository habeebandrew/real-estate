import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pro_2/generated/l10n.dart';
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
  late String selectedState;
  late String selectedGovernorate;
  late String selectedSortOrder;
  late String selectedRegion;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedState = S.of(context).All;
    selectedGovernorate = S.of(context).All_Cities;
    selectedSortOrder = S.of(context).Newest;
    selectedRegion = S.of(context).All;
    applyFilters();
  }

  void fetchPosts() async {
    final response = await http.get(
      Uri.parse(ApiAndEndpoints.api + ApiAndEndpoints.getpost),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['posts'];
      print("Fetched posts data: $data"); // تحقق من البيانات القادمة
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
        // تحقق من مطابقة الحالة
        bool matchesState = selectedState == S.of(context).All ||
            post.translateState(context) == selectedState;

        // تحقق من مطابقة المحافظة
        bool matchesGovernorate =
            selectedGovernorate == S.of(context).All_Cities ||
                post.translateGovernorate(context) == selectedGovernorate;

        // تحقق من مطابقة المنطقة
        bool matchesRegion = selectedRegion == S.of(context).All ||
            post.region == selectedRegion;

        return matchesState && matchesGovernorate && matchesRegion;
      }).toList();

      // ترتيب النتائج
      if (selectedSortOrder == S.of(context).Newest) {
        filteredPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else {
        filteredPosts.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              SizedBox(
                width: Dimensions.widthPercentage(context, 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedState,
                    isExpanded: true,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    items: [
                      S.of(context).All,
                      S.of(context).buy,
                      S.of(context).rental,
                    ]
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
              SizedBox(
                width: Dimensions.widthPercentage(context, 3),
              ),
              SizedBox(
                width: Dimensions.widthPercentage(context, 25),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedGovernorate,
                    isExpanded: true,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    items: [
                      S.of(context).All_Cities,
                      S.of(context).Damascus,
                      S.of(context).Rural_Damascus,
                      S.of(context).Aleppo,
                      S.of(context).Rural_Aleppo,
                      S.of(context).Homs,
                      S.of(context).Rural_Homs,
                      S.of(context).Latakia,
                      S.of(context).Rural_Latakia,
                      S.of(context).Tartous,
                      S.of(context).Rural_Tartous,
                      S.of(context).Hama,
                      S.of(context).Rural_Hama,
                      S.of(context).Idlib,
                      S.of(context).Rural_Idlib,
                      S.of(context).Dei_ez_Zor,
                      S.of(context).Rural_Deir_ez_Zor,
                      S.of(context).Raqqa,
                      S.of(context).Rural_Raqqa,
                      S.of(context).Al_Hasakah,
                      S.of(context).Rural_Al_Hasakah,
                      S.of(context).Daraa,
                      S.of(context).Rural_Daraa,
                      S.of(context).As_Suwayda,
                      S.of(context).Rural_As_Suwayda,
                      S.of(context).Quneitra,
                      S.of(context).Rural_Quneitra
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
              SizedBox(
                width: Dimensions.widthPercentage(context, 3),
              ),
              SizedBox(
                width: Dimensions.widthPercentage(context, 22),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSortOrder,
                    isExpanded: true,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    items: [S.of(context).Newest, S.of(context).Oldest]
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
              Spacer(),
              Text(
                '${S.of(context).Posts} ${filteredPosts.length}',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : filteredPosts.isEmpty
              ? Center(
                  child: Text(S.of(context).no_data,
                      style: TextStyle(fontSize: 18)))
              : ListView.builder(
                  itemCount: filteredPosts.length,
                  itemBuilder: (context, index) {
                    var post = filteredPosts[index];
                    return PostCard_with_comments(
                      description: post.description,
                      phone: post.mobilenumber,
                      selectedArea: post.region,
                      status: post.translateState(context),
                      selectedGovernorate: post.translateGovernorate(context),
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
