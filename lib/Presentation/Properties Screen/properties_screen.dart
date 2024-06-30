import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Presentation/Properties%20Screen/Properties%20Widgets/properties_widgets.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';
import 'package:pro_2/Util/global%20Widgets/my_form_field.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PropertiesScreen extends StatefulWidget {
  const PropertiesScreen({super.key});

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyCubit, PropertyState>(
        listener: (context, state) {
          if(state is PropertyErrorState) {
            mySnackBar(
              title: state.error,
              context: context,
              color: Colors.red,
            );
          }
          if(state is FavouriteAddedState){
            mySnackBar(
                title: 'Added Successfully',
                context: context,
            );
          }
          if(state is FavouriteDeletedState){
            mySnackBar(
                title: 'Deleted Successfully',
                context: context,
            );

          }
        },
        builder: (context, state) {
          PropertyCubit cubit = PropertyCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: RefreshIndicator(
              onRefresh: ()async{
                //context.read<PropertyCubit>().getProperty(context,(CacheHelper.getInt(key: 'id'))!);
                cubit.filterSelection(context);
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyFormField(
                            controller: cubit.searchController,
                            hintText: 'search ',
                            radius: 10.0,
                            fill: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {},
                          child: const CircleAvatar(
                            backgroundColor: Constants.mainColor,
                            child: Icon(Icons.filter_list, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0
                    ),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton(
                          dropdownColor: Colors.white,
                            underline: const SizedBox(),
                            value: cubit.dropDownStatus,
                            onChanged: (String? value){
                               setState(() {
                                 cubit.dropDownStatus = value!;
                               });
                            },
                            items:[
                              DropdownMenuItem(
                                  value:'all',
                                  child: const Text('all'),
                                  onTap: (){
                                    cubit.dropDownStatus='all';
                                    cubit.filterSelection(context);
                                  },
                              ),
                              DropdownMenuItem(
                                  value:'sale',
                                  child: const Text('sale'),
                                  onTap: (){
                                    cubit.dropDownStatus='sale';
                                   cubit.filterSelection(context);
                                  },
                              ),
                              DropdownMenuItem(
                                  value:'rent',
                                  child: const Text('rent'),
                                  onTap: (){
                                    cubit.dropDownStatus ='rent';
                                   cubit.filterSelection(context);
                                  },
                              )
                            ],
                        ),
                        const SizedBox(width:  20.0),
                        DropdownButton(
                            dropdownColor: Colors.white,
                            underline: const SizedBox(),
                            value: cubit.dropDownItemCites,
                            onChanged: (String? value){
                               setState(() {
                               cubit.dropDownItemCites = value!;
                               });
                            },
                            items:[
                              DropdownMenuItem(
                                  value:'all Cities',
                                  onTap: (){
                                    cubit.dropDownItemCites='all Cities';
                                    cubit.filterSelection(context);
                                  },
                                  child: const Text('all Cities'),
                              ),
                              DropdownMenuItem(
                                  value:'Damascus',
                                  onTap: (){
                                    cubit.dropDownItemCites='Damascus';
                                    cubit.filterSelection(context);
                                  },
                                  child: const Text('Damascus'),
                              ),
                              DropdownMenuItem(
                                  value:'Rif-Damascus',
                                  onTap:(){
                                    cubit.dropDownItemCites='Rif-Damascus';
                                    cubit.filterSelection(context);
                                  } ,
                                  child: const Text('Rif-Damascus'),
                              ),
                              DropdownMenuItem(
                                  value:'Homs',
                                  onTap: (){
                                    cubit.dropDownItemCites='Homs';
                                    cubit.filterSelection(context);
                                  },
                                  child: const Text('Homs'),
                              )
                            ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Container(
                    width: double.infinity,
                    height: Dimensions.heightPercentage(context, 7),
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: CupertinoSlidingSegmentedControl(
                                  children: {
                                    0: Text(
                                      'all',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: cubit.sliding == 0
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    1: Text(
                                      'house',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: cubit.sliding == 1
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    2: Text(
                                      'office',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: cubit.sliding == 2
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    3: Text(
                                      'villa',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: cubit.sliding == 3
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    4: Text(
                                      'farm',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: cubit.sliding == 4
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    5: Text(
                                      'market',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: cubit.sliding == 5
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    6: Text(
                                      'Land',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: cubit.sliding == 6
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    7: Text(
                                      'Building',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: cubit.sliding == 7
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                    8: Text(
                                      'Chalet',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: cubit.sliding == 8
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  },
                                  thumbColor: Constants.mainColor,
                                  backgroundColor: Constants.mainColor2,
                                  groupValue: cubit.sliding,
                                  onValueChanged: (value) {
                                    cubit.toggleSelectedFilter(value!, context);
                                  }),
                            ),
                          ),
                          Text(
                            state is PropertyLoadedState?' ${state.propertyModel.length} item':' ... item',
                            style: TextStyle(
                                color: Constants.mainColor, fontSize: 17.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (state is PropertyLoadingState)
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
                  if (state is PropertyLoadedState)
                    Expanded(
                      child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: state.propertyModel.length,
                        itemBuilder: (context, index) {
                          final property = state.propertyModel[index];
                          return PropertyCard(
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
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }
}
