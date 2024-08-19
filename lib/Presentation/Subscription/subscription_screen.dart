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
    setState((){
      if(CacheHelper.getInt(key: 'role_id')==2) {
      getMySubscibtion(context);
      }
    });
    

  }
  TextEditingController emailController = TextEditingController();
  bool isloading =false;

  late GeSubModel subInfo; 

  void addMySubscibtion(BuildContext context,String email)async{
     isloading=true;
     await addSubscibtion(email).then((value)async{
      if(value !='you do not have an account or valid card to pay.'){
        await CacheHelper.deleteInt(key: 'role_id');
        await CacheHelper.putInt(key: 'role_id',value: value.roleId);
        mySnackBar(
            context: context,
            title: 'Subscibtion Added Successfully'
        );
        setState(() {
          isloading=false;
          getMySubscibtion(context);
        });
       
      }else{
        setState(() {
          isloading=false;
        });
        
         mySnackBar(
            context: context,
            color: Colors.red,
            title: 'you do not have an account or valid card to pay.'
        );
        
      }
    });

  }

  void getMySubscibtion(BuildContext context)async{
     isloading=true;
     await getSubscibtion().then((value)async{
      if(value != 'Failed to load Subscribtion'){
        setState(() {
          isloading=false;
        subInfo = value;
        });
        
      }else{
         isloading=false;
         mySnackBar(
            context: context,
            color: Colors.red,
            title: 'get Subscibtion details Failed'
        );
        
      }
    });

  }

 Future addSubscibtion(String email) async {
    
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
      } else if(data.statusCode==400){
        
        return "you do not have an account or valid card to pay.";
        
      }
     
  }

  Future getSubscibtion() async {
    try {
      String token = (CacheHelper.getString(key: 'token'))!;
      debugPrint(token);
      var data =
        await NetworkHelper.get(ApiAndEndpoints.subscribeDetails, headers: {
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
           
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  setState((){
                       addMySubscibtion(context, emailController.text);
                  });
                  
                 }, 
                 minWidth: 50.0, 
                 height: 50.0
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
