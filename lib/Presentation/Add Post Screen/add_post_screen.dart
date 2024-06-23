import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pro_2/Util/constants.dart';

import '../../../Util/app_routes.dart';
import '../../../Util/global Widgets/animation.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostState();
}

class _AddPostState extends State<AddPostScreen> {
  // String? governorate = 'دمشق';
  // String? area = 'ساحة العباسيين';
  bool isBuying = true;

  String? selectedGovernorate = 'دمشق';
  String? selectedArea = 'ساحة العباسيين';
  TextEditingController budgetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
            Text('Add Wanted'),
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
                  items: [
                    'دمشق',
                    'ريف دمشق',
                    'حلب',
                    'ريف حلب',
                    'حمص',
                    'ريف حمص',
                    'حماة',
                    'ريف حماة',
                    'طرطوس',
                    'السويداء',
                    'دير الزور',
                    'درعا',
                    'الحسكة',
                    'القنيطرة',
                    'الرقة'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 18, // تغيير حجم الخط داخل القائمة
                          fontWeight:
                              FontWeight.w500, // تغيير سماكة الخط داخل القائمة
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGovernorate = newValue!;
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
                  items: ['ساحة العباسيين', 'المزة', 'المالكي']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 18, // تغيير حجم الخط داخل القائمة
                          fontWeight:
                              FontWeight.w500, // تغيير سماكة الخط داخل القائمة
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
                TextField(
                  controller: budgetController,
                  decoration: InputDecoration(
                    labelText: 'Budget \$',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor,
                        // تغيير لون الخط إلى الأحمر عند التركيز على الحقل
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor,
                        // تغيير لون الخط إلى الأحمر عند عدم التركيز على الحقل
                        width: 2.0, // تغيير سماكة الخط
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Add text',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor, // تغيير لون الخط إلى الأحمر
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor,
                        // تغيير لون الخط إلى الأحمر عند عدم التركيز على الحقل
                        width: 2.0, // تغيير سماكة الخط
                      ),
                    ),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    labelStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor, // تغيير لون الخط إلى الأحمر
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
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Constants.mainColor,
                        // تغيير لون الخط إلى الأحمر عند عدم التركيز على الحقل
                        width: 2.0, // تغيير سماكة الخط
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.mainColor4),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MyAnimation.createRoute(AppRoutes.confirmAddPost));
                      },
                      child: Text('Next '),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Constants.mainColor2),
                    ),
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
