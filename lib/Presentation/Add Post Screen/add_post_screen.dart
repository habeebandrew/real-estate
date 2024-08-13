import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pro_2/Util/constants.dart';
import 'package:pro_2/Util/global%20Widgets/my_button.dart';
import '../../../Util/app_routes.dart';
import '../../../Util/global Widgets/animation.dart';
import '../../Util/cache_helper.dart';
import '../Confirm Add Post/confirm_add_post.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostState();
}

class _AddPostState extends State<AddPostScreen> {
  String? number = CacheHelper.getString(key: 'number');

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
    // ... (remaining data unchanged)
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
            SizedBox(width: 10),
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
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
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
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),


                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (number != null) {
                              phoneController.text = number!;
                            }
                          },
                          child: Text('Use Current Number'),
                        ),
                      ),

                  SizedBox(height: 20),
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