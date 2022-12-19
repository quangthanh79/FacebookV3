import 'dart:io';

import 'package:camera/camera.dart';
import 'package:facebook_auth/blocs/authen/authentication_bloc.dart';
import 'package:facebook_auth/screen/home_screen/home_bloc/home_bloc.dart';
import 'package:facebook_auth/screen/home_screen/home_body.dart';
import 'package:facebook_auth/screen/login/login_screen.dart';
import 'package:facebook_auth/screen/main_facebook.dart';
import 'package:facebook_auth/screen/splash/splash_screen.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/context_ext.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'blocs/authen/authentication_state.dart';
import 'firebase/handle_message.dart';
import 'firebase_options.dart';

/**
 * Created by @Author: Tuan Pham Anh
 * Project : Facebook
 * Create Time : 03:37 - 20/10/2022
 * For all issue contact me : tuan.pa173443@sis.hust.edu.vn
 * Class main using BLoC Architecture
 */
late final List<CameraDescription> cameras;
late final Socket socketListConversation;
late final Socket socketDetailConversation;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("message noti : ${message.messageId}");
}

void main() async {
  socketListConversation = io(
      baseIP,
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  socketDetailConversation = io(
      baseIP,
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();
  await configureDependencies();
  await getIt.allReady();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  handleMessage();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => ListPostNotify(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeBloc(getIt(), getIt()),
            ),
            BlocProvider(create: (context) => AuthenticationBloc())
          ],
          child: AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  NavigatorState get _navigator => navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(fontFamily: 'OpenSans', platform: TargetPlatform.android),
        builder: (context, child) {
          return BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  _navigator.pushNamedAndRemoveUntil(
                      '/main_facebook', (Route<dynamic> route) => false);
                  break;
                case AuthenticationStatus.unauthenticated:
                  _navigator.pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                  break;
                case AuthenticationStatus.unknown:
                  break;
              }
            },
            child: child,
          );
        },
        onGenerateRoute: (settings) {
          if (settings.name == "/main_facebook") {
            return MainFacebookScreen.route();
          }
          if (settings.name == "/login") {
            return LoginScreen.route();
          }
          return SplashScreen.route();
        });
  }
}
