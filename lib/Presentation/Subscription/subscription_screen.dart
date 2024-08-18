import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pro_2/Data/add_subscribe_model.dart';
import 'package:pro_2/Data/ge_sub_model.dart';
import 'package:pro_2/Util/api_endpoints.dart';
import 'package:pro_2/Util/cache_helper.dart';
import 'package:pro_2/Util/global%20Widgets/mySnackBar.dart';
import 'package:pro_2/Util/global%20Widgets/my_button.dart';
import 'package:pro_2/Util/global%20Widgets/my_form_field.dart';
import 'package:pro_2/Util/network_helper.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {

  @override
  void initState() {
    super.initState();

    if(CacheHelper.getInt(key: 'role_id')==2) {
      getMySubscibtion(context);
    }

  }


 
  TextEditingController emailController = TextEditingController();
  bool isloading =false;

  late GeSubModel subInfo; 

  void addMySubscibtion(BuildContext context,String email)async{
     isloading=true;
     await addSubscibtion(email).then((value)async{
      if(value.message== 'you are a real estate BROKER now, use feature and contact us if something wrong happens to you.'){
        await CacheHelper.deleteInt(key: 'role_id');
        await CacheHelper.putInt(key: 'role_id',value: value.roleId);
        mySnackBar(
            context: context,
            title: 'Subscibtion Added Successfully'
        );
        isloading=false;
      }else{
         mySnackBar(
            context: context,
            color: Colors.red,
            title: 'Subscibtion Failed'
        );
      }
    });

  }

  void getMySubscibtion(BuildContext context)async{
     isloading=true;
     await getSubscibtion().then((value)async{
      if(value != 'Failed to load Subscribtion'){
        isloading=false;
        subInfo = value;
      }else{
         mySnackBar(
            context: context,
            color: Colors.red,
            title: 'get Subscibtion details Failed'
        );
      }
    });

  }

 Future addSubscibtion(String email) async {
    try {
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data =
          await NetworkHelper.post(ApiAndEndpoints.subscribe, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }, body: {
        'email': email,
      });
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200 || data.statusCode == 201) {
        var res = addSubscribeModelFromJson(data.body);
        return res;
      } else {
        return 'Failed to add Subscribtion';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future getSubscibtion() async {
    try {
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data =
        await NetworkHelper.get(ApiAndEndpoints.subscribe, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
        },
      );
      print(data.statusCode);
      print(data.body);
      if (data.statusCode == 200 || data.statusCode == 201) {
        var res = geSubModelFromJson(data.body);
        return res;
      } else {
        return 'Failed to load Subscribtion';
      }
    } catch (e) {
      return e.toString();
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Subscription'),
      ),
      body: Center(
           
        child: Column(
        
          children: [
            if(CacheHelper.getInt(key: 'role_id')==1)
             MyFormField(
              controller: emailController,
              hintText: 'enter your email',
             ),
             if(CacheHelper.getInt(key: 'role_id')==1)
              isloading==true?CircularProgressIndicator()
              :MyButton(
               tittle: 'add', 
               onPreessed: (){
                addMySubscibtion(context, emailController.text);
               }, 
               minWidth: 50.0, 
               height: 100.0
              ),
      
            if(CacheHelper.getInt(key: 'role_id')==2)
               isloading?const CircularProgressIndicator()
              :Column(
                 children: [
                   Text(subInfo.startDate),
                   Text(subInfo.endDate),
                   Text(subInfo.daysRemaining),
                ],
            ),
            
          ],
        ),
        ),
      );
    
  
  }
}
  
  

// Future<void> updateRole(BuildContext context) async {
// try {

// int my_id = (await CacheHelper.getInt(key: 'id'))!;

//     var response = await NetworkHelper.put(
//       ApiAndEndpoints.updateRole , headers: {'Content-Type': 'application/json'},  body: {
//       "user_id": my_id,
//       "role_id": 2,

//     },
//     );
//     if (response.statusCode == 200) {

//       mySnackBar(
//         context: context,
//         title: 'Subscribed successful',
//       );
//       Future.delayed(const Duration(seconds:1), () {
//         Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
//       });
//     } else {

//     mySnackBar(
//         context: context,
//         title: 'Subscribed failed',
//       );    }
//   } catch (e) {

// mySnackBar(
//       context: context,
//       title: 'Subscribed failed try again later',
//     );   }
// }
