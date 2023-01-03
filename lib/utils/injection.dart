import 'package:dio/dio.dart';
import 'package:facebook_auth/core/helper/cache_helper.dart';
import 'package:facebook_auth/data/datasource/remote/authen_api_provider.dart';
import 'package:facebook_auth/data/datasource/remote/comment_datasource.dart';
import 'package:facebook_auth/data/datasource/remote/like_datasource.dart';
import 'package:facebook_auth/data/datasource/local/user_local_data.dart';
import 'package:facebook_auth/data/datasource/remote/profile_api_provider.dart';
import 'package:facebook_auth/data/repository/authen_repository.dart';
import 'package:facebook_auth/data/repository/friend_repository.dart';
import 'package:facebook_auth/data/repository/profile_repository.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/domain/use_cases/add_post_use_case.dart';
import 'package:facebook_auth/domain/use_cases/get_user_info_use_case.dart';
import 'package:facebook_auth/domain/use_cases/like_use_case%20copy.dart';
import 'package:facebook_auth/domain/use_cases/like_use_case.dart';
import 'package:facebook_auth/domain/use_cases/load_comment_use_case.dart';
import 'package:facebook_auth/domain/use_cases/set_comment_use_case.dart';
import 'package:facebook_auth/data/datasource/remote/chat_api_provider.dart';
import 'package:facebook_auth/data/repository/chat_repository.dart';
import 'package:facebook_auth/screen/home_screen/like_bloc/like_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/networking/api_service.dart';
import '../data/datasource/remote/post_datasource.dart';
import '../data/repository/comment_repository_impl.dart';
import '../data/repository/like_repository_impl.dart';
import '../data/repository/post_repository_impl.dart';
import '../domain/repositories/comment_repository.dart';
import '../domain/repositories/like_repository.dart';
import '../domain/repositories/post_repository.dart';
import '../domain/use_cases/load_list_posts_use_case.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // getIt.registerSingleton<SignUpBloc>(SignUpBloc(AuthenRepository()));
  getIt.registerSingleton<ChatApiProvider>(ChatApiProvider());

  getIt.registerSingletonAsync<ChatRepository>(() async {
    var repository = ChatRepository();
    return repository.init();
  });

  getIt.registerFactory<LikeBloc>(
    () => LikeBloc(getIt()),
  );
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
  getIt.registerSingleton(
      CacheHelper(await getIt.getAsync<SharedPreferences>()));

  getIt.registerFactory(() => Dio());
  getIt.registerFactory(() => ApiService(getIt()));
  // datasource
  getIt.registerFactory<PostDataSource>(
      () => PostDataSourceImpl(apiService: getIt()));
  getIt.registerFactory<CommentDataSource>(
      () => CommentDataSourceImpl(apiService: getIt()));
  getIt.registerFactory<LikeDataSource>(
      () => LikeDataSourceImpl(apiService: getIt()));
  getIt.registerSingleton<AuthenApiProvider>(AuthenApiProvider());
  getIt.registerSingleton<ProfileApiProvider>(ProfileApiProvider());
  getIt.registerSingletonAsync<UserLocalDataSource>(() async {
    return UserLocalDataSource(await SharedPreferences.getInstance());
  });

  // repositories
  getIt.registerSingleton<UserRepository>(UserRepository());
  getIt.registerSingleton<FriendRepository>(FriendRepository());
  getIt.registerFactory<PostRepository>(
      () => PostRepositoryImpl(dataSource: getIt()));
  getIt.registerFactory<CommentRepository>(
      () => CommentRepositoryImpl(dataSource: getIt()));
  getIt.registerFactory<LikeRepository>(
      () => LikeRepositoryImpl(dataSource: getIt()));
  getIt.registerSingletonAsync<ProfileRepository>(() async {
    var repository = ProfileRepository();
    return await repository.init();
  });
  getIt.registerSingletonAsync<AuthenRepository>(() async {
    var repository = AuthenRepository();
    return await repository.init();
  });

  // usecases
  getIt.registerSingleton(LoadListPostUseCase(postRepository: getIt()));
  getIt.registerSingleton(AddPostUseCase(repository: getIt()));
  getIt.registerSingleton(LoadCommentUseCase(commentRepository: getIt()));
  getIt.registerSingleton(SetCommentUseCase(commentRepository: getIt()));
  getIt.registerFactory<LikeUseCase>(() => LikeUseCase(repository: getIt()));
  getIt.registerFactory<DeletePostUseCase>(
      () => DeletePostUseCase(repository: getIt()));
  getIt.registerFactory<GetUserInfoUseCase>(
      () => GetUserInfoUseCase(repository: getIt()));
}
