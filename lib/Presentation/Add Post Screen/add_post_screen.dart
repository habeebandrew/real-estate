import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Bloc/Posts%20Cubit/posts_cubit.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/my_button.dart';

import '../../../Util/app_routes.dart';
import '../../../Util/global Widgets/animation.dart';
import '../../Util/global Widgets/mySnackBar.dart';
import '../../Util/global Widgets/my_form_field.dart';

import '../../Util/global Widgets/my_form_field.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostState();
}

class _AddPostState extends State<AddPostScreen> {
  bool isBuying = true;
  String State = "";//isBuyingهاي منشان اعطيا قيمة بيع او شراء حسب
  String? selectedGovernorate = 'دمشق';
  String? selectedArea = 'المزة';
  TextEditingController budgetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final Map<String, List<String>> governorateToAreas = {
//هون قارن مع كي فايندر وضيف باقي المناطق والمدن
  'دمشق': ['ساحة العباسيين', 'المزة', 'المالكي'],
  'ريف دمشق': ['دوما', 'حرستا', 'سقبا'],
  'حلب': ['حي السبيل', 'سيف الدولة', 'الأعظمية'],
  'ريف حلب': ['منبج', 'الباب', 'جرابلس'],
  'حمص': ['الوعر', 'الحميدية', 'الخالدية'],
  'ريف حمص': ['تلكلخ', 'الرستن', 'تلبيسة'],
  'اللاذقية': ['الشيخ ضاهر', 'الصليبة', 'الرمل الجنوبي'],
  'ريف اللاذقية': ['جبلة', 'القرداحة', 'الحفة'],
  'طرطوس': ['بانياس', 'صافيتا', 'الدريكيش'],
  'ريف طرطوس': ['الشيخ بدر', 'القدموس', 'مشتى الحلو'],
  'حماة': ['حي القصور', 'حي الشريعة', 'حي الأربعين'],
  'ريف حماة': ['السلمية', 'مصياف', 'صوران'],
  'إدلب': ['معرة النعمان', 'أريحا', 'جسر الشغور'],
  'ريف إدلب': ['كفرنبل', 'خان شيخون', 'سراقب'],
  'دير الزور': ['البوكمال', 'الميادين', 'حي الحميدية'],
  'ريف دير الزور': ['البصيرة', 'هجين', 'الشحيل'],
  'الرقة': ['تل أبيض', 'عين عيسى', 'الطبقة'],
  'ريف الرقة': ['سلوك', 'الكرامة', 'المحمودلي'],
  'الحسكة': ['القامشلي', 'رأس العين', 'الشدادي'],
  'ريف الحسكة': ['تل تمر', 'معبدة', 'اليعربية'],
  'درعا': ['بصرى الشام', 'نوى', 'طفس'],
  'ريف درعا': ['داعل', 'إنخل', 'جاسم'],
  'السويداء': ['شهبا', 'صلخد', 'عرمان'],
  'ريف السويداء': ['القريا', 'عرى', 'ملح'],
  'القنيطرة': ['خان أرنبة', 'البعث', 'القنيطرة المحررة'],
  'ريف القنيطرة': ['جباتا الخشب', 'طرنجة', 'مجدل شمس']

};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/images/General/App_Icon1.png',
              width: 50,
              height: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'C',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constants.mainColor,
                          fontSize: 13.h,
                        ),
                      ),
                      TextSpan(
                        text: 'apital',
                        style: TextStyle(
                          color: Constants.mainColor,
                          fontSize: 9.h,
                        ),
                      ),
                      TextSpan(
                        text: ' E',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constants.mainColor,
                          fontSize: 13.h,
                        ),
                      ),
                      TextSpan(
                        text: 'states',
                        style: TextStyle(
                          color: Constants.mainColor,
                          fontSize: 9.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Spacer(),
            Text('Add Wanted',style: TextStyle(color: Constants.mainColor),),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context)
              .push(MyAnimation.createRoute(AppRoutes.homeScreen));

          return true; // Return true to allow back navigation, false to prevent it
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Wanted',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Constants.mainColor)),
                    SizedBox(width: 20),
                    Checkbox(
                      value: !isBuying,
                      onChanged: (bool? value) {
                        setState(() {
                          isBuying = !value!;
                        });
                      },
                    ),
                    Text('Rent'),
                    SizedBox(width: 20),
                    Checkbox(
                      value: isBuying,
                      onChanged: (bool? value) {
                        setState(() {
                          isBuying = value!;
                        });
                      },
                    ),
                    Text('Buy'),
                  ],
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedGovernorate,
                  decoration: InputDecoration(
                    labelText: 'Governorate',
                    labelStyle: TextStyle(
                      fontSize: 20, // تغيير حجم الخط
                      fontWeight: FontWeight.bold, // تغيير سماكة الخط
                      color: Constants.mainColor, // تغيير لون النص إلى الأحمر
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor, // تغيير لون الخط إلى الأحمر
                        width: 2.0, // تغيير سماكة الخط
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor,
                        // تغيير لون الخط إلى الأحمر عند تمكين الحقل
                        width: 2.0, // تغيير سماكة الخط
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor,
                        // تغيير لون الخط إلى الأحمر عند التركيز على الحقل
                        width: 2.0, // تغيير سماكة الخط
                      ),
                    ),
                  ),
                  items: governorateToAreas.keys.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGovernorate = newValue;
                      selectedArea = null; // Reset the selected area
                    });
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedArea,
                  decoration: InputDecoration(
                    labelText: 'Region',
                    labelStyle: TextStyle(
                      fontSize: 20, // تغيير حجم الخط
                      fontWeight: FontWeight.bold, // تغيير سماكة الخط
                      color: Constants.mainColor, // تغيير لون النص إلى الأحمر
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor, // تغيير لون الخط إلى الأحمر
                        width: 2.0, // تغيير سماكة الخط
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor,
                        // تغيير لون الخط إلى الأحمر عند تمكين الحقل
                        width: 2.0, // تغيير سماكة الخط
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor,
                        // تغيير لون الخط إلى الأحمر عند التركيز على الحقل
                        width: 2.0, // تغيير سماكة الخط
                      ),
                    ),
                  ),
                  items: selectedGovernorate == null
                      ? []
                      : governorateToAreas[selectedGovernorate]!.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedArea = newValue!;
                    });
                  },
                ),
                SizedBox(height: 20),
                MyFormField(
                  controller: budgetController,
                  labelText: 'Budget \$',
                  type: TextInputType.number,
                  radius: 15.0,
                ),
                SizedBox(height: 20),
                MyFormField(
                  controller: descriptionController,
                  labelText: 'Add description',
                  type: TextInputType.text,
                  radius: 15.0,
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                MyFormField(
                  controller: phoneController,
                  labelText: 'Mobile Number',
                  type: TextInputType.phone,
                  radius: 15.0,
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyButton(tittle: "Cancel", onPreessed: (){Navigator.pop(context);}, minWidth: 100, height: 20),
                    MyButton(tittle: " Next ", onPreessed: (){
    Navigator.of(context).push(
    MyAnimation.createRoute(AppRoutes.confirmAddPost));
                    }, minWidth: 100, height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//***************************************
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../Bloc/Posts Cubit/posts_cubit.dart';
// import '../../Util/constants.dart';
// import '../../Util/global Widgets/animation.dart';
// import '../../Util/global Widgets/mySnackBar.dart';
// import '../../Util/global Widgets/my_button.dart';
// import '../../Util/global Widgets/my_form_field.dart';
// import '../../Util/app_routes.dart';
//
// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({super.key});
//
//   @override
//   State<AddPostScreen> createState() => _AddPostState();
// }
//
// class _AddPostState extends State<AddPostScreen> {
//   bool isBuying = true;
//   final Map<String, List<String>> governorateToAreas = {
//     'دمشق': ['ساحة العباسيين', 'المزة', 'المالكي'],
//     'ريف دمشق': ['دوما', 'حرستا', 'سقبا'],
//     'حلب': ['حي السبيل', 'سيف الدولة', 'الأعظمية'],
//     'ريف حلب': ['منبج', 'الباب', 'جرابلس'],
//     'حمص': ['الوعر', 'الحميدية', 'الخالدية'],
//     'ريف حمص': ['تلكلخ', 'الرستن', 'تلبيسة'],
//     'اللاذقية': ['الشيخ ضاهر', 'الصليبة', 'الرمل الجنوبي'],
//     'ريف اللاذقية': ['جبلة', 'القرداحة', 'الحفة'],
//     'طرطوس': ['بانياس', 'صافيتا', 'الدريكيش'],
//     'ريف طرطوس': ['الشيخ بدر', 'القدموس', 'مشتى الحلو'],
//     'حماة': ['حي القصور', 'حي الشريعة', 'حي الأربعين'],
//     'ريف حماة': ['السلمية', 'مصياف', 'صوران'],
//     'إدلب': ['معرة النعمان', 'أريحا', 'جسر الشغور'],
//     'ريف إدلب': ['كفرنبل', 'خان شيخون', 'سراقب'],
//     'دير الزور': ['البوكمال', 'الميادين', 'حي الحميدية'],
//     'ريف دير الزور': ['البصيرة', 'هجين', 'الشحيل'],
//     'الرقة': ['تل أبيض', 'عين عيسى', 'الطبقة'],
//     'ريف الرقة': ['سلوك', 'الكرامة', 'المحمودلي'],
//     'الحسكة': ['القامشلي', 'رأس العين', 'الشدادي'],
//     'ريف الحسكة': ['تل تمر', 'معبدة', 'اليعربية'],
//     'درعا': ['بصرى الشام', 'نوى', 'طفس'],
//     'ريف درعا': ['داعل', 'إنخل', 'جاسم'],
//     'السويداء': ['شهبا', 'صلخد', 'عرمان'],
//     'ريف السويداء': ['القريا', 'عرى', 'ملح'],
//     'القنيطرة': ['خان أرنبة', 'البعث', 'القنيطرة المحررة'],
//     'ريف القنيطرة': ['جباتا الخشب', 'طرنجة', 'مجدل شمس']
//
//   };
//
//   @override
//   Widget build(BuildContext context) {
//     var cubit = PostsCubit.get(context);
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             Image.asset(
//               'assets/images/General/App_Icon1.png',
//               width: 50,
//               height: 50,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: 'C',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Constants.mainColor,
//                           fontSize: 13.h,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'apital',
//                         style: TextStyle(
//                           color: Constants.mainColor,
//                           fontSize: 9.h,
//                         ),
//                       ),
//                       TextSpan(
//                         text: ' E',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Constants.mainColor,
//                           fontSize: 13.h,
//                         ),
//                       ),
//                       TextSpan(
//                         text: 'states',
//                         style: TextStyle(
//                           color: Constants.mainColor,
//                           fontSize: 9.h,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Spacer(),
//             Text('Add Wanted',style: TextStyle(color: Constants.mainColor),),
//           ],
//         ),
//       ),
//       body: WillPopScope(
//         onWillPop: () async {
//           Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.homeScreen));
//           return true;
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: SingleChildScrollView(
//             child: BlocConsumer<PostsCubit, PostsState>(
//               listener: (context, state) {
//                 if (state is PostsErrorState) {
//                   mySnackBar(context: context, title: state.message);
//                 }
//               },
//               builder: (context, state) {
//                 if (state is PostsLoadingState) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Row(
//                       children: [
//                         Text('Wanted', style: TextStyle(fontWeight: FontWeight.bold, color: Constants.mainColor)),
//                         // باقي عناصر الصف
//                       ],
//                     ),
//                     // باقي تصميم الحقول
//                     MyFormField(
//                       controller: cubit.budgetController,
//                       labelText: 'Budget \$',
//                       type: TextInputType.number,
//                       radius: 15.0,
//                     ),
//                     SizedBox(height: 20),
//                     MyFormField(
//                       controller: cubit.descriptionController,
//                       labelText: 'Add description',
//                       type: TextInputType.text,
//                       radius: 15.0,
//                       maxLines: 3,
//                     ),
//                     SizedBox(height: 20),
//                     MyFormField(
//                       controller: cubit.phoneController,
//                       labelText: 'Mobile Number',
//                       type: TextInputType.phone,
//                       radius: 15.0,
//                     ),
//                     SizedBox(height: 40),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         MyButton(
//                           tittle: "Cancel",
//                           onPreessed: () {
//                             Navigator.pop(context);
//                           },
//                           minWidth: 100,
//                           height: 20,
//                         ),
//                         MyButton(
//                           tittle: "Next",
//                           onPreessed: () {
//                             cubit.addPost(context);
//                           },
//                           minWidth: 100,
//                           height: 20,
//                         ),
//                       ],
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
