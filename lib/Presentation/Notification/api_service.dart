import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:pro_2/Presentation/Notification/notification_function.dart';

import '../../Data/Notification_model.dart';
import '../../Util/api_endpoints.dart';
import '../../Util/cache_helper.dart';
import '../../Util/network_helper.dart';

Future<List<Notification>> fetchNotifications() async {
  String token = (await CacheHelper.getString(key: 'token'))!;

  try {
    final response = await NetworkHelper.get(
      ApiAndEndpoints.showMyNotifications,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<Notification> notifications = jsonResponse.map((data) => Notification.fromJson(data)).toList();

      // تصفية الإشعارات التي لم يتم قراءتها فقط
      List<Notification> unreadNotifications = notifications.where((notification) => notification.isRead == 0).toList();

      // عرض الإشعارات غير المقروءة باستخدام awesome_notifications
      for (var notification in unreadNotifications) {
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: notification.id,
            channelKey: 'basic_channel',
            title: 'New Notification',
            body: notification.content,
          ),
        );
      }

      return notifications;
    } else {
      throw Exception('Failed to load notifications');
    }
  } catch (error) {
    print('Error fetching notifications: $error');
    // إعادة المحاولة بعد فترة قصيرة
    await Future.delayed(Duration(seconds: 5));
    return await fetchNotifications(); // محاولة التحميل مجددًا
  }
}

