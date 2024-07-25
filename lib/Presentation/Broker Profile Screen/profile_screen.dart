import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Presentation/Properties%20Screen/Properties%20Widgets/properties_widgets.dart';
import 'package:pro_2/Presentation/Property%20Details%20Screen/property_details_screen.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/animation.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class BrokerProfileScreen extends StatefulWidget {

  int id;
  String name;
  String brokerImage;
  BrokerProfileScreen({super.key, required this.id,required this.name,required this.brokerImage});

  @override
  State<BrokerProfileScreen> createState() => _BrokerProfileScreen();
}

class _BrokerProfileScreen extends State<BrokerProfileScreen> {
  
  late double rate;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PropertyCubit()..getBrokerInfo(context, widget.id),
      child: BlocConsumer<PropertyCubit, PropertyState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit=PropertyCubit.get(context);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text('Broker'),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  if((CacheHelper.getInt(key: 'id'))! != widget.id)
                  PopupMenuButton(
                    color: Constants.mainColor4,
                    itemBuilder: (_)=><PopupMenuItem<String>>[
                      const PopupMenuItem(
                        value: '1',
                        child: Text('Report')
                      )
                    ],
                    onSelected: (index){
                      switch(index){
                       case '1':{
                        cubit.reportOnBroker(context,(CacheHelper.getInt(key: 'id'))! , widget.id);
                       }
                      }
                    },
                  )
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  if(selected==false){
                     cubit.getBrokerInfo(context, widget.id);
                  }else if(selected==true){
                     cubit.getBrokerProperty(context, widget.id); 
                  }
                },
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 180,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Constants.mainColor,
                            // image: DecorationImage(
                            //   image: AssetImage('assets/car_image.png'),
                            //   fit: BoxFit.cover,
                
                            // ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            children: [

                               CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(widget.brokerImage),
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                widget.name,
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
                                    if(selected ==false){
                                      cubit.getBrokerInfo(context, widget.id);
                                    }
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
                    
                    if(selected == false && state is PropertyLoadingState)
                      Expanded(
                        child: ListView.builder(
                             
                            itemCount: 3,
                            itemBuilder: (context, index) => Container(
                                  width: double.infinity,
                                  height: 100.h,
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
                   
                    if (selected == false&&state is BrokerInfoLoadedState) 
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ListView(
                        shrinkWrap: true,
                         children: [
                           if((CacheHelper.getInt(key: 'id'))! != widget.id)
                            Row(
                              children: [
                                const Text(
                                  'Rate:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0
                                  ),
                                ),
                                const SizedBox(width: 8),
                                RatingBar.builder(
                                  initialRating: rate = state.info.evaluate.toDouble(),
                                  maxRating: 5,
                                  minRating: 0,
                                  allowHalfRating: false,
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      rate = rating;
                                      
                                    });
                                    
                                    if(rate > 0.0 && state.info.evaluate == 0){
                                      cubit.rateOnBroker(
                                        context, 
                                        (CacheHelper.getInt(key: 'id'))!, 
                                        widget.id, 
                                        rate
                                      );
                                      state.info.evaluate=rate.toInt();
                                    }

                                    if(rate > 0.0 && state.info.evaluate > 0){
                                       cubit.updateRateOnBroker(
                                        context, 
                                        (CacheHelper.getInt(key: 'id'))!, 
                                        widget.id, 
                                        rate
                                      );
                                      state.info.evaluate=rate.toInt();
                                    }

                                    if(rate == 0.0){
                                       cubit.deleteRateOnBroker(context);
                                       state.info.evaluate=0;
                                    }   
                        
                                  },
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  itemCount: 5,
                                  itemPadding:
                                      const EdgeInsets.symmetric(horizontal: 4.0),
                                  itemSize: 30.0,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                             const SizedBox(height: 16),
                            if(state.info.phoneNumber != null)
                            const Text(
                              'Contact Information:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0
                              ),
                            ),
                            if(state.info.phoneNumber != null)
                            const SizedBox(height: 8),
                            if(state.info.phoneNumber != null)
                             Padding(
                               padding: const EdgeInsetsDirectional.only(
                                end: 150.0
                                ),
                               child: InkWell(
                                 onTap: ()async{
                                  final url =
                                        'tel:${state.info.phoneNumber!}';
                                    debugPrint('phone:$url');
                                    if (await canLaunchUrl(Uri.parse(url))) {
                                      await launchUrl(Uri.parse(url));
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                 },
                                 child: Container(
                                   width: 100 ,
                                   height: 50.0,
                                   decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                   child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                 
                                    children: [
                                      const Icon(Icons.phone),
                                      const SizedBox(width: 20.0),
                                      Text(state.info.phoneNumber!,
                                       style: const TextStyle(
                                        fontSize: 18.0
                                       ),
                                    
                                      )
                                      
                                    ],
                                  ),
                                 ),
                               ),
                             ),
                            
                          ],
                        ),
                     ),
                    
                      //ContactInformation(),
                    if(selected==true && state is PropertyLoadingState)
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
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
                          shrinkWrap: false,
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
              ),
            );
          }),
    );
  }
}