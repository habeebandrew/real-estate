
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
      name: 'on_the_beach',
      imageUrl: 'assets/images/Home/on_the_beach.jpg',
      onTap: () {
        print('Farm category tapped');
        // Add your functionality here
      },
    ),
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
            'Types of properties >',
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
class mostviewer extends StatefulWidget {
  const mostviewer({super.key});

  @override
  State<mostviewer> createState() => _mostviewerState();
}

class _mostviewerState extends State<mostviewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.asset(
                  'assets/images/Home/on_the_beach.jpg',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(decoration: BoxDecoration( color: Constants.mainColor,borderRadius: BorderRadius.circular(5)),
                 
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'للبيع'
                    ,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,fontSize: 18
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '35 million sp',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),textDirection:TextDirection.rtl,
                ),
                Text(
                  'شاليه 200 م²',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.visibility),
                        SizedBox(width: 5),
                        Text('452'),
                      ],
                    ),
                    Text(
                      'طرطوس/المدينة',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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