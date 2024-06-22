import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Property%20Cubit/property_cubit.dart';
import 'package:pro_2/Presentation/Properties%20Screen/Properties%20Widgets/properties_widgets.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/dimensions.dart';
import 'package:pro_2/Util/global%20Widgets/my_form_field.dart';

class PropertiesScreen extends StatelessWidget {
  const PropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PropertyCubit, PropertyState>(
        listener: (context, state) {},
        builder: (context, state) {
          PropertyCubit cubit = PropertyCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:MyFormField(
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
                        onTap: (){},
                        child: const CircleAvatar(
                          backgroundColor: Constants.mainColor,
                          child: Icon(
                              Icons.filter_list,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
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
                              },
                              thumbColor: Constants.mainColor,
                              backgroundColor: Constants.mainColor2,
                              groupValue: cubit.sliding,
                              onValueChanged: (value) {
                                cubit.toggleSelected(value!);
                              }
                          ),
                        ),
                        Text(
                          ' 3328 item',
                          style: TextStyle(
                              color: Constants.mainColor,
                              fontSize: 17.sp
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    //shrinkWrap: true,
                    itemBuilder: (context, value) => PropertyCard(),
                    itemCount: 2,
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}
