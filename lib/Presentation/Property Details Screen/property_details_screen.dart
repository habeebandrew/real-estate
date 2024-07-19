import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Presentation/Broker%20Profile%20Screen/profile_screen.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class PropertyDetailsScreen extends StatefulWidget {

    PropertyDetailsScreen({
    super.key,
    required this.propertyId,
    required this.favourite,
  });

   int propertyId;
   bool favourite;

  @override
  State<PropertyDetailsScreen> createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PropertyCubit()..getPropertyDetails(widget.propertyId),
      child: BlocConsumer<PropertyCubit, PropertyState>(
        listener: (context, state) {
          if (state is PropertyErrorState) {
            mySnackBar(title: state.error, context: context, color: Colors.red);
          }
        },
        builder: (context, state) {
          PropertyCubit cubit = PropertyCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text('Property'),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context, widget.favourite);
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              actions: [
                IconButton(
                  icon: widget.favourite == true
                      ? const Icon(Icons.favorite, color: Colors.red)
                      : const Icon(Icons.favorite_border),
                  onPressed: () {
                    if (widget.favourite) {
                      cubit.deleteMyFavourite(context, widget.propertyId);
                    } else {
                      cubit.addMyFavourite(context, widget.propertyId);
                    }
                    setState(() {
                      widget.favourite = !widget.favourite;
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context
                    .read<PropertyCubit>()
                    .getPropertyDetails(widget.propertyId);
              },
              child: ListView(
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state is PropertyLoadingState)
                          Container(
                            width: double.infinity,
                            height: Dimensions.screenHeight(context) / 2,
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Shimmer(
                              color: Constants.mainColor,
                              duration: const Duration(milliseconds: 2000),
                              child: Container(),
                            ),
                          ),
                        if (state is PropertyDetailsLoadedState)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 200,
                                    child: PageView.builder(
                                      onPageChanged: (index) {
                                        setState(() {
                                          currentIndex = index;
                                        });
                                      },
                                      itemCount: state
                                          .propertyDetailsModel.images.length,
                                      itemBuilder: (context, index) {
                                        return Image.network(
                                          state.propertyDetailsModel
                                              .images[index],
                                          fit: BoxFit.cover,
                                          width:
                                              Dimensions.screenHeight(context),
                                          height:
                                              Dimensions.screenHeight(context),
                                        );
                                      },
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                  Positioned(
                                    bottom:
                                        Dimensions.heightPercentage(context, 2),
                                    left: 0.0,
                                    right: 0.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                          state.propertyDetailsModel.images
                                              .length, (index) {
                                        return AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          height: Dimensions.widthPercentage(
                                              context, 2),
                                          width: currentIndex == index
                                              ? Dimensions.widthPercentage(
                                                  context, 4)
                                              : Dimensions.widthPercentage(
                                                  context, 2),
                                          decoration: BoxDecoration(
                                            color: currentIndex == index
                                                ? Constants.mainColor
                                                : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${state.propertyDetailsModel.property.propertyType} : ${state.propertyDetailsModel.property.size} m²',
                                      style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${state.propertyDetailsModel.property.viewers}',
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                        SizedBox(width: 8.w),
                                        const Icon(Icons.visibility),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on, size: 16.sp),
                                    Text(
                                      '${state.propertyDetailsModel.property.address} - ${state.propertyDetailsModel.property.governorate}',
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'show on map',
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16.sp,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 5.0),
                                child: Text(
                                  state.propertyDetailsModel.property.status ==
                                          'sale'
                                      ? '${state.propertyDetailsModel.property.price} sp'
                                      : '${state.propertyDetailsModel.property.price} monthly/sp',
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  'Description :',
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8.0),
                                child: Text(
                                  state.propertyDetailsModel.property
                                      .description!,
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.grey),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Property characteristics :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Table(
                                  border: TableBorder(
                                      horizontalInside: BorderSide(
                                    color: Colors.grey.shade100,
                                  )),
                                  columnWidths: const {
                                    0: FixedColumnWidth(155),
                                  },
                                  children: [
                                    if (state.propertyDetailsModel.property
                                            .rentalPeriod !=
                                        null)
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.timer_outlined,
                                                  size: 20.sp,
                                                  color: Constants.mainColor,
                                                ),
                                                SizedBox(
                                                  width: 5.0.w,
                                                ),
                                                Text('Rental Duration',
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${state.propertyDetailsModel.property.rentalPeriod}',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Constants.mainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    TableRow(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.house_outlined,
                                                color: Constants.mainColor,
                                                size: 20.sp,
                                              ),
                                              SizedBox(
                                                width: 5.0.w,
                                              ),
                                              Text('Area (m²)',
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${state.propertyDetailsModel.property.size}',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Constants.mainColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (state.propertyDetailsModel.property
                                            .floor !=
                                        null)
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_city_outlined,
                                                  size: 20.sp,
                                                  color: Constants.mainColor,
                                                ),
                                                SizedBox(
                                                  width: 5.0.w,
                                                ),
                                                Text('Number of Floors',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${state.propertyDetailsModel.property.floor}',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Constants.mainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (state.propertyDetailsModel.property
                                            .ownerOfTheProperty !=
                                        null)
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .manage_accounts_outlined,
                                                  color: Constants.mainColor,
                                                  size: 20.sp,
                                                ),
                                                SizedBox(
                                                  width: 5.0.w,
                                                ),
                                                Text('Owner of property',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              state.propertyDetailsModel
                                                  .property.ownerOfTheProperty!,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Constants.mainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (state.propertyDetailsModel.property
                                            .numberOfRoom !=
                                        null)
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.room_preferences,
                                                  color: Constants.mainColor,
                                                  size: 20.sp,
                                                ),
                                                SizedBox(
                                                  width: 5.0.w,
                                                ),
                                                Text('Number of Rooms',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${state.propertyDetailsModel.property.numberOfRoom}',
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Constants.mainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (state.propertyDetailsModel.property
                                            .furnished !=
                                        null)
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.roofing_outlined,
                                                  color: Constants.mainColor,
                                                  size: 20.sp,
                                                ),
                                                SizedBox(
                                                  width: 5.0.w,
                                                ),
                                                Text('Furnishing',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              state.propertyDetailsModel
                                                  .property.furnished!,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Constants.mainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (state.propertyDetailsModel.property
                                            .direction !=
                                        null)
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.directions,
                                                  color: Constants.mainColor,
                                                  size: 20.sp,
                                                ),
                                                SizedBox(
                                                  width: 5.0.w,
                                                ),
                                                Text('Direction',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              state.propertyDetailsModel
                                                  .property.direction!,
                                              style: TextStyle(
                                                color: Constants.mainColor,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (state.propertyDetailsModel.property
                                            .condition !=
                                        null)
                                      TableRow(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.newspaper_outlined,
                                                  color: Constants.mainColor,
                                                  size: 20.sp,
                                                ),
                                                SizedBox(
                                                  width: 5.0.w,
                                                ),
                                                Text('Condition',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp,
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              state.propertyDetailsModel
                                                  .property.condition!,
                                              style: TextStyle(
                                                color: Constants.mainColor,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              if (state.propertyDetailsModel.features != [])
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    'Extra Features :',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              if (state.propertyDetailsModel.features != [])
                                Column(
                                  children: List.generate(
                                    (state.propertyDetailsModel.features
                                                .length /
                                            2)
                                        .ceil(),
                                    (index) {
                                      final startIndex = index * 2;
                                      final endIndex = (startIndex + 2 <=
                                              state.propertyDetailsModel
                                                  .features.length)
                                          ? startIndex + 2
                                          : state.propertyDetailsModel.features
                                              .length;
                                      final pair = state
                                          .propertyDetailsModel.features
                                          .sublist(startIndex, endIndex);
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Row(
                                          mainAxisAlignment: state
                                                      .propertyDetailsModel
                                                      .features
                                                      .length ==
                                                  1
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.spaceAround,
                                          children: pair
                                              .map((featureItem) =>
                                                  Text(featureItem.feature))
                                              .toList(),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'Ad details :',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                                child: Table(
                                  border: TableBorder(
                                      horizontalInside: BorderSide(
                                    color: Colors.grey.shade100,
                                  )),
                                  columnWidths: const {
                                    0: FixedColumnWidth(155),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.manage_accounts_rounded,
                                              color: Constants.mainColor,
                                              size: 20.sp,
                                            ),
                                            SizedBox(width: 5.0.w),
                                            Text('Posted By',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.sp,
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            
                                            Navigator.push(context, 
                                              MaterialPageRoute(
                                                builder:(context)=> BrokerProfileScreen(
                                                  id: state.propertyDetailsModel.property.userId,
                                                  name: state.propertyDetailsModel.property.userName,
                                                ),
                                              )
                                            );
                                          },
                                          child: Text(
                                            state.propertyDetailsModel.property.userName,
                                            style: TextStyle(
                                              color: Constants.mainColor,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ]),
                ],
              ),
            ),
            bottomNavigationBar: state is PropertyDetailsLoadedState
                ? InkWell(
                    onTap: () async {
                      final url =
                          'tel:${state.propertyDetailsModel.property.phone_number}';
                      debugPrint('phone:$url');
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: BottomAppBar(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Contact with Broker',
                            style: TextStyle(
                              fontSize: 20.sp,
                            )),
                        const Icon(Icons.phone)
                      ],
                    )),
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }
}
