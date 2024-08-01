import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:pro_2/Presentation/Notification/notification_function.dart';

class notification extends StatefulWidget {
  const notification({super.key});

  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  void initState() {
    super.initState();

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) => {
    if(!isAllowed){AwesomeNotifications().requestPermissionToSendNotifications()}

  });

  }
// @override
// void initState() {
//   super.initState();
//
//   // طلب الإذن للإشعارات إذا لم يكن ممنوحاً
//   AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//     if (!isAllowed) {
//       AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   });
//
//   // جدولة الإشعارات
//   // showNotification();
// }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: TextButton(
        onPressed: () {
          showNotification();
          // يمكن إضافة وظائف أخرى هنا إذا لزم الأمر
        },
        child: Text('Send'),
      ),
    ),
  );
}
}