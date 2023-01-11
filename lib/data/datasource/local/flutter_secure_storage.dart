import 'package:facebook_auth/data/models/user_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static String TOKEN = "TOKEN";
  static String ID_USER = "ID_USER";

  final _storage = FlutterSecureStorage();

  SecureStorage._privateConstructor();

  static final SecureStorage _instance = SecureStorage._privateConstructor();

  static SecureStorage get instance => _instance;

  setUserData(UserStorage userStorage) async {
    if (userStorage.token != null) {
      await _storage.write(key: TOKEN, value: userStorage.token);
      await _storage.write(key: ID_USER, value: userStorage.idUser);
    }
  }

  Future<UserStorage> getUserData() async {
    return UserStorage(
        token: await _storage.read(key: TOKEN),
        idUser: await _storage.read(key: ID_USER),
    );
  }

  clearUserData() async {
    await _storage.delete(key: TOKEN);
    await _storage.delete(key: ID_USER);
  }
}
