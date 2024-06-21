import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';

Widget favourite_item(BuildContext context)
  =>Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0
    ),
    child: Dismissible(
      //key هو ايدي الشغلة يلي بدنا نحذفا من المفضلة
      key: const Key('sss'),
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              width: double.infinity,
              height: Dimensions.heightPercentage(context, 16),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'office : 17 m²',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '246 Million S.p',
                            style: TextStyle(
                              fontSize: 23.sp,
                              fontWeight: FontWeight.bold,
                              color: Constants.mainColor,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              //مشان يفتح الموقع علخريطة

                            },
                            child: Row(
                              children: [
                                Icon(
                                    Icons.location_on,
                                    size: 16.sp
                                ),
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
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      'assets/images/Home/apartment.jpg',
                      // Replace with the actual image URL
                      width: Dimensions.screenWidth(context)/3,
                      height: Dimensions.heightPercentage(context, 16),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Constants.mainColor,
                borderRadius: BorderRadius.circular(5),
              ),
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child:  Text(
                'Sale',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );