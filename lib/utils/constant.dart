import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String TYPE_IMAGE = 'TPYE_IMAGE';
const String TYPE_VIDEO = 'TPYE_VIDEO';

const int MAX_LENGTH_TEXT = 100;

const String baseIP = "http://184.169.213.180:3000";
// const String baseIP = "http://192.168.1.239:3000";
// const String testIP = "http://10.0.2.2:3000";
const String baseUrl = baseIP + "/it4788/";
// const String testUrl = testIP + "/it4788/";

Future<String?> token = const FlutterSecureStorage().read(key: 'token');

const String timeOut = 'Request time out!';
const String networkUnavailable = 'Can\'t connect to internet!';
const String unexpectedError = 'Something went wrong!';

const String postToken =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYzNjg3M2NjNmIwYmE1NzAyNDc1MWQzOCIsImRhdGVMb2dpbiI6IjIwMjItMTEtMzBUMDM6MzY6MDguODU5WiIsImlhdCI6MTY2OTc3OTM2OSwiZXhwIjoxNjc5Nzc5MzY4fQ.9yVyMd4Uvu_Wpcvg6q53F5ohgXytZHVcb1mgH-c2Vuo';
const int count = 7;
const String defaultAvatar = 'assets/images/no_image.png';
const userName = 'SonNN';
const avatarUrl = 'assets/images/no_image.png';

enum Optional { error, success, empty }
