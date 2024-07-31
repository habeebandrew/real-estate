import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

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

Future<List<Map<String, dynamic>>> loadMessages() async {
  final jsonString = await rootBundle.loadString('assets/notification/daily_messages.json');
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.cast<Map<String, dynamic>>();
}
// الحصول على العبارة المناسبة لليوم
Future<String> getDailyMessage() async {
  final messages = await loadMessages();
  final today = DateTime.now().day; // الحصول على اليوم الحالي من الشهر
  final dailyMessage = messages.firstWhere((msg) => msg['day'] == today, orElse: () => {'message': 'Default message'});
  return dailyMessage['message'];
}

Future<void> scheduleDailyNotification() async {
  final dailyMessage = await getDailyMessage();

  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1, // استخدام معرّف فريد للإشعار
      channelKey: 'basic_channel',
      title: 'Daily Notification',
      body: dailyMessage,
    ),
    schedule: NotificationCalendar(
      hour: 15,
      minute: 30,
      second: 0,
      millisecond: 0,
      timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
      repeats: true,
    ),
  );
}
