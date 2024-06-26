import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';

class FavouriteItem extends StatefulWidget {
   FavouriteItem({
    super.key,
    required this.id,
    required this.propertyType,
    required this.status,
    required this.governorate,
    required this.address,
    required this.createdAt,
    required this.size,
    required this.price,
    required this.images,
  });
  int id;
  String propertyType;
  String status;
  String governorate;
  String address;
  String createdAt;
  int size;
  int price;
  List<String> images;

  @override
  State<FavouriteItem> createState() => _FavouriteItemState();
}

class _FavouriteItemState extends State<FavouriteItem> {


  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
      ),
      child: Dismissible(
        //key هو ايدي الشغلة يلي بدنا نحذفا من المفضلة
        key: Key(widget.id.toString()),
        onDismissed: (DismissDirection dismissAction){

        },
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
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.propertyType} : ${widget.size} m²',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              widget.status=='sale'
                              ?'${widget.price} Million S.p'
                              :'${widget.price} Million/MonthS.p',
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
                                    '${widget.address} - ${widget.governorate}',
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
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15)
                          ),
                          color: widget.images.isEmpty
                              ?Constants.mainColor3
                              :Colors.white,
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
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
                                      itemCount: widget.images.length,
                                      itemBuilder: (context, index) {
                                        return Image.network(
                                          widget.images[index],
                                          fit: BoxFit.cover,
                                          width: Dimensions.screenHeight(context),
                                          height: Dimensions.screenHeight(context),
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                    ),
                                    Positioned(
                                      bottom: Dimensions.heightPercentage(context, 1),
                                      left: 0.0,
                                      right: 0.0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: List.generate(widget.images.length, (index) {
                                          return AnimatedContainer(
                                            duration: const Duration(milliseconds: 300),
                                            margin:
                                            const EdgeInsets.symmetric(horizontal: 4.0),
                                            height: Dimensions.widthPercentage(context, 2),
                                            width: currentIndex == index
                                                ? Dimensions.widthPercentage(context, 4)
                                                : Dimensions.widthPercentage(context, 2),
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
                              child:  Text(
                                'for ${widget.status}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}



