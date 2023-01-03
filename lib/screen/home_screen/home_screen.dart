import 'package:facebook_auth/data/repository/post_repository_impl.dart';
import 'package:facebook_auth/screen/home_screen/home_bloc/home_bloc.dart';
import 'package:facebook_auth/screen/home_screen/home_body.dart';
import 'package:facebook_auth/utils/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider(
        create: (context) => HomeBloc(getIt(), getIt()),
        child: const HomeBody(
          type: PostType.home,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
