import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';

class PropertyCard extends StatefulWidget {
  const PropertyCard({super.key});

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  final List<String> images = [
    'https://via.placeholder.com/600x400',
    'https://via.placeholder.com/600x400',
    'https://via.placeholder.com/600x400',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: 348.h,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Constants.mainColor2,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(5, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        PageView.builder(
                          onPageChanged: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              images[index],
                              fit: BoxFit.cover,
                              width: screenWidth,
                              height: screenHeight,
                            );
                          },
                          scrollDirection: Axis.horizontal,
                        ),
                        Positioned(
                          bottom: screenHeight * 0.02,
                          left: 0.0,
                          right: 0.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(images.length, (index) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                height: screenWidth * 0.02,
                                width: currentIndex == index
                                    ? screenWidth * 0.04
                                    : screenWidth * 0.02,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? Constants.mainColor
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    )),
                Container(
                  decoration: const BoxDecoration(
                    color: Constants.mainColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: const Text(
                    'for rent',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('house : 240 m²',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w900)),
                    SizedBox(height: 8.h),
                    Text(
                      '120 million S.p',
                      style: TextStyle(
                          color: Constants.mainColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.location_on, size: 16.sp),
                          SizedBox(width: 4.w),
                          Text(
                            'Alassad Suburb - Damascus',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text('8 hours ago',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.sp,
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {},
                        child: const Icon(Icons.favorite_border),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          '240',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        SizedBox(width: 8.w),
                        const Icon(Icons.visibility),
                      ],
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
