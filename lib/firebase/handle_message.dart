import 'package:firebase_messaging/firebase_messaging.dart';

import '../utils/notification.dart';

void handleMessage(){
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("AAAAA-----------${message.data?.toString() ?? "DATA"}-----------AAAAAA");
    print(
        'message noti ${message.notification?.body} ${message.notification?.title}');
    showNotification(
        message.notification?.title ?? "Không có tiêu đề", message.notification?.body ?? "Không có nội dung", message.data);
    // userNotificationBloc.fetchNotifications(SessionUser.user.userId);
  });
}