import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

import '../../Util/app_routes.dart';
import '../../Util/cache_helper.dart';
import '../../Util/constants.dart';
import '../../Util/global Widgets/animation.dart';
import '../../generated/l10n.dart';
import 'api_service.dart';

// void fetchAndScheduleNotifications() async {
//   // تحقق من وجود إشعارات مجدولة مسبقًا
//   List<NotificationModel> scheduledNotifications = await AwesomeNotifications().listScheduledNotifications();
//
//   // إذا لم تكن هناك إشعارات مجدولة، قم بإنشاء إشعارات جديدة
//   if (scheduledNotifications.isEmpty) {
//     AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 1, // استخدام معرف فريد للإشعار
//         channelKey: 'basic_channel',
//         title: 'Capital Estate',
//         body: 'Check last updates in your app',
//       ),
//       schedule: NotificationInterval(
//         interval: 5, // كل 60 ثانية
//         timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//         repeats: true,
//       ),
//     );
//   }
// }
//
// Future<void> showNotification() async {
//   // تحقق من وجود إشعارات مجدولة مسبقًا
//   List<NotificationModel> scheduledNotifications = await AwesomeNotifications().listScheduledNotifications();
//
//   // تحقق مما إذا كان هناك إشعار مجدول بالفعل
//   bool isNotificationScheduled = scheduledNotifications.isNotEmpty;
//
//   if (!isNotificationScheduled) {
//     AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 10  , // استخدام معرّف فريد للإشعار
//         channelKey: 'basic_channel',
//         title: 'Notification',
//         body: 'This is a test notification sent every minute',
//       ),
//       schedule: NotificationInterval(
//         interval: 60, // كل 60 ثانية
//         timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//         repeats: true,
//       ),
//     );
//   }
// }
//
// Future<List<Map<String, dynamic>>> loadMessages() async {
//   final jsonString = await rootBundle.loadString('assets/notification/daily_messages.json');
//   final List<dynamic> jsonList = jsonDecode(jsonString);
//   return jsonList.cast<Map<String, dynamic>>();
// }
// // الحصول على العبارة المناسبة لليوم
// Future<String> getDailyMessage() async {
//   final messages = await loadMessages();
//   final today = DateTime.now().day; // الحصول على اليوم الحالي من الشهر
//   final dailyMessage = messages.firstWhere((msg) => msg['day'] == today, orElse: () => {'message': 'Default message'});
//   return dailyMessage['message'];
// }
//
// Future<void> scheduleDailyNotification() async {
//   final dailyMessage = await getDailyMessage();
//
//   AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: 1, // استخدام معرّف فريد للإشعار
//       channelKey: 'basic_channel',
//       title: 'Daily Notification',
//       body: dailyMessage,
//     ),
//     schedule: NotificationCalendar(
//       hour: 15,
//       minute: 30,
//       second: 0,
//       millisecond: 0,
//       timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//       repeats: true,
//     ),
//   );
// }
void showNotificationSheet(BuildContext context) {
  int? role_id = CacheHelper.getInt(key: 'role_id');
  String? token = CacheHelper.getString(key: 'token');

  token!=null?
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<List<Notification>>(
        future: fetchNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications available yet.'));
          }

          final notifications = snapshot.data!;

          return Container(
            padding: EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.8, // 80% من ارتفاع الشاشة
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      final notification = notifications[index];
                      return NotificationItem(notification: notification);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  ): showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    title: Text(
      S.of(context).alert,
      style: TextStyle(
          color: Colors.red, fontWeight: FontWeight.bold),
    ),
    content: Text("سجل دخول لترى اشعارات"),//S.of(context).new....
    actions: <Widget>[
      TextButton(
        child: Text(
          S.of(context).Log_In,
          style: TextStyle(
              color: Constants.mainColor,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).push(
              MyAnimation.createRoute(
                  AppRoutes.logInScreen));
        },
      ),
    ],
  ));
}
class Notification {
  final int id;
  final String createdAt;
  final String content;
  final int isRead;

  Notification({required this.id, required this.createdAt, required this.content, required this.isRead});

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      createdAt: json['created_at'],
      content: json['content'],
      isRead: json['isRead'],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final Notification notification;

  NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    // تحويل التاريخ إلى الشكل المطلوب
    final dateFormat = DateFormat('yyyy-MM-dd');
    final formattedDate = dateFormat.format(DateTime.parse(notification.createdAt));

    return ListTile(
      leading: Icon(
        notification.isRead == 0 ? Icons.notifications : Icons.notifications_active,
        color: notification.isRead == 0 ? Colors.red : Colors.grey,
      ),
      title: Text(notification.content),
      subtitle: Text(formattedDate),
      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
      tileColor: notification.isRead == 0 ? Colors.yellow[100] : Colors.transparent,
      onTap: () {
        // التعامل مع نقر الإشعار
      },
    );
  }
}