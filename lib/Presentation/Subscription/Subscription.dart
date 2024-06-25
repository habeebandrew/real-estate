import 'package:flutter/material.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/global Widgets/animation.dart';
import '../../Util/global Widgets/mySnackBar.dart';
import '../../Util/network_helper.dart';
class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
        title: Text('Subscription'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showSubscriptionDialog(context),
          child: Text('Subscribe'),
        ),
      ),
    );
  }

  void _showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Subscription Confirmation'),
          content: Text('Do you really want to subscribe?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {updateRole(context);
              },
              child: Text('Subscribe'),
            ),
          ],
        );
      },
    );
  }
}
  // body: {
  //       "user_id": my_id,
  //       "role_id": "2",
  //
  //     },
Future<void> updateRole(BuildContext context) async {
try {

int my_id = (await CacheHelper.getInt(key: 'id'))!;

    var response = await NetworkHelper.put(
      ApiAndEndpoints.updateRole , headers: {'Content-Type': 'application/json'},  body: {
      "user_id": my_id,
      "role_id": 2,

    },
    );
    if (response.statusCode == 200) {

      mySnackBar(
        context: context,
        title: 'Subscribed successful',
      );
      Future.delayed(const Duration(seconds:1), () {
        Navigator.of(context).push(MyAnimation.createRoute(AppRoutes.logInScreen));
      });
    } else {

    mySnackBar(
        context: context,
        title: 'Subscribed failed',
      );    }
  } catch (e) {

mySnackBar(
      context: context,
      title: 'Subscribed failed try again later',
    );   }
}
