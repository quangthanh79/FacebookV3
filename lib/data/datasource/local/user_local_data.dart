import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDataSource {
  static String USER_NOTIFICATION_TOKEN = "USER_NOTIFICATION_TOKEN";
  SharedPreferences _prefs;

  UserLocalDataSource(this._prefs);

  setUserNotificationToken(String token) async {
    await _prefs.setString(USER_NOTIFICATION_TOKEN, token);
  }

  clearUserNotificationToken() async {
    await _prefs.remove(USER_NOTIFICATION_TOKEN);
  }

  Future<String?> getUserNotificationToken() async {
    return await _prefs.getString(USER_NOTIFICATION_TOKEN);
  }
}
