import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_service.dart';
import 'package:pro_2/Presentation/Profile%20Screen/Profile%20Screen%20Widgets/profile_screen_widgets.dart';
import 'package:pro_2/Presentation/Properties%20Screen/Properties%20Widgets/properties_widgets.dart';
import 'package:pro_2/Presentation/Property%20Details%20Screen/property_details_screen.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/animation.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ProfileScreen extends StatefulWidget {

  int id;
  
  ProfileScreen({super.key, required this.id});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  

  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyCubit(),
      child: BlocConsumer<PropertyCubit, PropertyState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit=PropertyCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('Brokers'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Constants.mainColor,
                          image: DecorationImage(
                            image: AssetImage('assets/car_image.png'),
                            fit: BoxFit.cover,
              
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage('assets/alkhair_logo.png'),
                            ),
                            SizedBox(width: 16.w),
                            Text(
                              'Mohammad Khair Alsarayji',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          width: 250.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    selected = true;
                                  });
                                  if(selected==true){
                                    cubit.getBrokerProperty(context, widget.id);
                                  }
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: selected
                                      ? Colors.white
                                      : Constants.mainColor,
                                  backgroundColor: selected
                                      ? Constants.mainColor
                                      : Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                                child: const Text('Ads'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    selected = false;
                                  });
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: selected == false
                                      ? Colors.white
                                      : Constants.mainColor,
                                  backgroundColor: selected == false
                                      ? Constants.mainColor
                                      : Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                                child: const Text('Profile Information'),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  if (selected == false) 
                    ContactInformation(),
                  if(selected==true && state is PropertyLoadingState)
                    Expanded(
                      child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) => Container(
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
                                child: Shimmer(
                                  color: Constants.mainColor,
                                  duration: const Duration(milliseconds: 1000),
                                  child: Container(),
                                ),
                              )),
                    ),  
                  if(selected==true && state is PropertyLoadedState) 
                    Expanded(
                      child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: state.propertyModel.length,
                        itemBuilder: (context, index) {
                          final property = state.propertyModel[index];
                          return GestureDetector(
                            onTap: ()async{
                             Navigator.push(
                                  context, 
                                  MyAnimation.createRoute(PropertyDetailsScreen(
                                    propertyId: property.id,
                                    favourite: property.existingFavorite,
                                    )
                                  )
                              );
                              // final updatedFavourite = await Navigator.push<bool>(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => PropertyDetailsScreen(
                              //       propertyId: property.id,
                              //       favourite: property.existingFavorite,
                              //     ),
                              //   ),
                              // );
                              

                                // // Handle the result here, updating the state if necessary
                                // if (updatedFavourite != null && updatedFavourite != property.existingFavorite) {
                                //   setState(() {
                                //     property.existingFavorite = updatedFavourite;
                                //   });
                                // }

                            },
                            child: PropertyCard(
                              id: property.id,
                              propertyType: property.propertyType,
                              status: property.status,
                              size: property.size,
                              price: property.price,
                              address: property.address,
                              governorate: property.governorate,
                              viewers: property.viewers,
                              inFavourite: property.existingFavorite,
                              createdAt: '${property.createdAt.substring(0,10)} - ${property.createdAt.substring(11,16)}',
                              images: property.images,
                            ),
                          );
                        },
                      ),
                    ),
                  
                ],
              ),
            );
          }),
    );
  }
}