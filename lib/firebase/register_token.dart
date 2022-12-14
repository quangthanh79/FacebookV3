

import 'package:facebook_auth/data/repository/authen_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../utils/injection.dart';

void registerToken() {
  FirebaseMessaging.instance.getToken().then((value) {
    print('--------------TOKEN FCM:$value');
    if (value != null) {
      getIt.get<AuthenRepository>().registerToken(value);
    }
  });
}