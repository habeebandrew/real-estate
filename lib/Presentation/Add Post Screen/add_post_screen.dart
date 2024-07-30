import 'package:flutter/material.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/my_button.dart';
import '../../../Util/app_routes.dart';
import '../../../Util/global Widgets/animation.dart';
import '../Confirm Add Post/confirm_add_post.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostState();
}

class _AddPostState extends State<AddPostScreen> {
  bool isBuying = true;
  String State = "buy";
  String? selectedGovernorate = 'Damascus';
  String? selectedArea = 'Mezzeh';
  TextEditingController budgetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final Map<String, List<String>> governorateToAreas = {
    'Damascus': ['Abbasid Square', 'Mezzeh', 'Maliki'],
    'Rural Damascus': ['Douma', 'Harasta', 'Saquba'],
    'Aleppo': ['Al-Sabil Neighborhood', 'Seif al-Dawla', 'Al-Azamiya'],
    'Rural Aleppo': ['Manbij', 'Al-Bab', 'Jarabulus'],
    'Homs': ['Al-Waer', 'Al-Hamidiyah', 'Al-Khalidiyah'],
    'Rural Homs': ['Talkalakh', 'Rastan', 'Talbiseh'],
    'Latakia': ['Sheikh Daher', 'Saliba', 'South Raml'],
    'Rural Latakia': ['Jableh', 'Qardaha', 'Haffa'],
    'Tartous': ['Baniyas', 'Safita', 'Dreikish'],
    'Rural Tartous': ['Sheikh Badr', 'Al-Qadmous', 'Mashta al-Helou'],
    'Hama': [
      'Al-Qusour Neighborhood',
      'Al-Sharia Neighborhood',
      'Al-Arbaeen Neighborhood'
    ],
    'Rural Hama': ['Salamiyah', 'Masyaf', 'Soran'],
    'Idlib': ['Maarrat al-Numan', 'Ariha', 'Jisr al-Shughur'],
    'Rural Idlib': ['Kafranbel', 'Khan Shaykhun', 'Saraqib'],
    'Deir ez-Zor': ['Al-Bukamal', 'Al-Mayadin', 'Al-Hamidiyah Neighborhood'],
    'Rural Deir ez-Zor': ['Al-Busaira', 'Hajin', 'Al-Shuhail'],
    'Raqqa': ['Tel Abyad', 'Ain Issa', 'Tabqa'],
    'Rural Raqqa': ['Suluk', 'Al-Karama', 'Al-Mahmoudli'],
    'Al-Hasakah': ['Qamishli', 'Ras al-Ayn', 'Al-Shaddadi'],
    'Rural Al-Hasakah': ['Tel Tamer', 'Maabda', 'Al-Ya rubiyah'],
    'Daraa': ['Bosra al-Sham', 'Nawa', 'Tafas'],
    'Rural Daraa': ['Dael', 'Inkhil', 'Jasim'],
    'As-Suwayda': ['Shahba', 'Salkhad', 'Arman'],
    'Rural As-Suwayda': ['Qarya', 'Ara', 'Mleh'],
    'Quneitra': ['Khan Arnabah', 'Al-Baath', 'Liberated Quneitra'],
    'Rural Quneitra': ['Jubata al-Khashab', 'Taranja', 'Majdal Shams']
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'C',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constants.mainColor,
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text: 'apital',
                        style: TextStyle(
                          color: Constants.mainColor,
                          fontSize: 9,
                        ),
                      ),
                      TextSpan(
                        text: ' E',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Constants.mainColor,
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text: 'states',
                        style: TextStyle(
                          color: Constants.mainColor,
                          fontSize: 9,
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
            Text('Add Wanted', style: TextStyle(color: Constants.mainColor)),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context)
              .push(MyAnimation.createRoute(AppRoutes.homeScreen));

          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                            State = isBuying ? "buy" : "rental";
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
                            State = isBuying ? "buy" : "rental";
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
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Constants.mainColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
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
                        selectedArea = null;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a governorate';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedArea,
                    decoration: InputDecoration(
                      labelText: 'Region',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Constants.mainColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    items: selectedGovernorate == null
                        ? []
                        : governorateToAreas[selectedGovernorate]!
                            .map((String value) {
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a region';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: budgetController,
                    decoration: InputDecoration(
                      labelText: 'Budget \$',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Constants.mainColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a budget';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter only numbers';
                      }
                      return null;
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Add description',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Constants.mainColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      } // Check if the input contains 9 or more digits
                      RegExp regex = RegExp(r'\d{9,}');
                      if (regex
                          .hasMatch(value.replaceAll(RegExp(r'\s+'), ''))) {
                        return 'It is not allowed to enter your phone number in the description';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Constants.mainColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          color: Constants.mainColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a mobile number';
                      }
                      if (value.length < 7 || value.length > 13) {
                        return 'Mobile number must be between 7 and 13 digits';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Please enter only numbers';
                      }
                      return null;
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyButton(
                          tittle: "Cancel",
                          onPreessed: () {
                            Navigator.of(context).push(
                                MyAnimation.createRoute(AppRoutes.homeScreen));
                          },
                          minWidth: 100,
                          height: 20),
                      MyButton(
                          tittle: " Next ",
                          onPreessed: () {
                            if (_formKey.currentState!.validate()) {
                              int budget = int.parse(budgetController.text);
                              int phone = int.parse(phoneController.text);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ConfirmAddPost(
                                    budget: budget,
                                    description: descriptionController.text,
                                    phone: phone,
                                    selectedArea: selectedArea ?? '',
                                    selectedGovernorate:
                                        selectedGovernorate ?? '',
                                    status: State,
                                  ),
                                ),
                              );
                            }
                          },
                          minWidth: 100,
                          height: 20),
                    ],
                  ),
                ],
              ),
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
