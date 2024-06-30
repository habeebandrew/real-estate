import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';

class PropertyCard extends StatefulWidget {
   PropertyCard({
    super.key,
    required this.id,
    required this.propertyType,
    required this.status,
    required this.governorate,
    required this.address,
    required this.createdAt,
    required this.size,
    required this.price,
    required this.viewers,
    required this.inFavourite,
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
  int viewers;
  bool inFavourite=false;
  List<String> images;

  @override
  State<PropertyCard> createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {


  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
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
                          bottom: Dimensions.heightPercentage(context, 2),
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
                    Text('${widget.propertyType} : ${widget.size} m²',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w900)),
                    SizedBox(height: 8.h),
                    Text(
                      widget.status=='sale'
                          ?'${widget.price} Million S.p'
                          :'${widget.price} Million/Month S.p',
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
                            '${widget.address} - ${widget.governorate}',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                        widget.createdAt,
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
                        onTap: (){
                          final cubit = PropertyCubit.get(context);
                          if (widget.inFavourite) {
                            cubit.deleteMyFavourite(context,widget.id);
                          } else {
                            cubit.addMyFavourite(context,widget.id);
                          }

                          setState(() {
                            widget.inFavourite = !widget.inFavourite;
                          });
                        },
                        child:widget.inFavourite==true
                        ?const Icon(
                            Icons.favorite,
                            color: Colors.red,
                        )
                        :const Icon(
                          Icons.favorite_border,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          '${widget.viewers}',
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
