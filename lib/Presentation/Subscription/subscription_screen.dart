import 'package:flutter/material.dart';
import 'package:pro_2/Util/global%20Widgets/my_form_field.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

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
            MyFormField(
              controller: TextEditingController(),
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
