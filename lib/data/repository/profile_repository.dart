
import 'package:facebook_auth/data/datasource/local/flutter_secure_storage.dart';
import 'package:facebook_auth/data/datasource/local/user_local_data.dart';
import 'package:facebook_auth/data/datasource/remote/profile_api_provider.dart';
import 'package:facebook_auth/utils/constant.dart';
import 'package:facebook_auth/utils/injection.dart';

class ProfileRepository{
  late UserLocalDataSource _userLocalDataSource;
  late ProfileApiProvider _profileApiProvider;

  Future<ProfileRepository> init() async {
    this._profileApiProvider = getIt.get<ProfileApiProvider>();
    this._userLocalDataSource = await getIt.getAsync<UserLocalDataSource>();
    return this;
  }
  Future<Optional> logout() async {
    final response = await _profileApiProvider.signOut();
    if (response == Optional.success) {
      _userLocalDataSource.clearUserNotificationToken();
      SecureStorage.instance.clearUserData();
    }
    return response;
  }
}