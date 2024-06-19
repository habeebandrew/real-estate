
import 'dart:async';

import 'package:flutter/material.dart';

import '../../../Util/constants.dart';


class Category {
  final String name;
  final String imageUrl;
  final VoidCallback onTap;

  Category({required this.name, required this.imageUrl, required this.onTap});
}

class CategorySection extends StatefulWidget {
  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final List<Category> categories = [
    Category(
      name: 'farm',
      imageUrl: 'assets/images/Home/farm.jpg',
      onTap: () {
        print('Farm category tapped');
        // Add your functionality here
      },
    ),
    Category(
      name: 'apartment',
      imageUrl: 'assets/images/Home/apartment.jpg',
      onTap: () {
        print('Apartment category tapped');
        // Add your functionality here
      },
    ),
    Category(
      name: 'office',
      imageUrl: 'assets/images/Home/office.jpg',
      onTap: () {
        print('Office category tapped');
        // Add your functionality here
      },
    ),
    Category(
      name: 'villa',
      imageUrl: 'assets/images/Home/villa.jpg',
      onTap: () {
        print('Villa category tapped');
        // Add your functionality here
      },
    ),
    Category(
      name: 'building',
      imageUrl: 'assets/images/Home/skyscraper-sunset.jpg',
      onTap: () {
        print('Building category tapped');
        // Add your functionality here
      },
    ),

  ];

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.8, // تخفيض العرض المرئي لكل عنصر
    );
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < categories.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            'Types of real estate>',
            style: TextStyle(color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.6,
          child: PageView.builder(
            controller: _pageController,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  // splashColor: Colors.white,
                  // focusColor:Colors.white,
                  // hoverColor: Colors.white,
                  // highlightColor: Colors.white,
                  splashColor: Constants.mainColor2,
                  focusColor:Constants.mainColor2,
                  hoverColor: Constants.mainColor2,
                  highlightColor: Constants.mainColor2,
                  onTap: categories[index].onTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color:Colors.white,
                      // Constants.mainColor2,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Constants.mainColor2,
                          // Color.fromARGB(255, 253, 253, 253),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              20), // تعديل الزاوية حسب ما تحتاج
                          child: Image.asset(
                            categories[index].imageUrl,
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.width * 0.35,
                            fit:
                            BoxFit.cover, // لتغطية المساحة بالصورة بشكل جيد
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          categories[index].name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}