

import 'dart:math';

import 'package:facebook_auth/data/models/user_info.dart';
import 'package:facebook_auth/data/repository/user_repository.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_bloc/edit_event.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_bloc/edit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocSystem {
  EditUsernameBloc? usernameBloc;
  EditAvatarBloc? avatarBloc;
  EditCoverImageBloc? coverImageBloc;
  EditDescriptionBloc? descriptionBloc;
  EditCountryBloc? countryBloc;
  EditCityBloc? cityBloc;
  EditAddressBloc? addressBloc;
  EditLinkBloc? linkBloc;

  BlocSystem({
    required User user,
    required UserRepository userRepository
  }){
    usernameBloc = EditUsernameBloc(user: user, userRepository: userRepository);
    avatarBloc = EditAvatarBloc(user: user, userRepository: userRepository);
    coverImageBloc = EditCoverImageBloc(user: user, userRepository: userRepository);
    descriptionBloc = EditDescriptionBloc(user: user, userRepository: userRepository);
    countryBloc = EditCountryBloc(user: user, userRepository: userRepository);
    cityBloc = EditCityBloc(user: user, userRepository: userRepository);
    addressBloc = EditAddressBloc(user: user, userRepository: userRepository);
    linkBloc = EditLinkBloc(user: user, userRepository: userRepository);
  }
}

class EditBloc extends Bloc<EditEvent, EditState>{
  User user;
  UserRepository userRepository;

  EditBloc({
    required this.user,
    required this.userRepository
  }) : super(EditState()) {
    on<ReloadEvent>(reloadInfor);
    on<CommitChangeEvent>(commitChange);
  }

  Future<void> reloadInfor(ReloadEvent e, Emitter<EditState> emit) async{
    print("reload ${user.description}");
    emit(EditState(random: Random().nextInt(10000)));
  }
  Future<void> commitChange(CommitChangeEvent e, Emitter<EditState> emit) async{
    bool? okay = await userRepository.setUserInfor(user);
    if (okay) {
      // emit(EditState());
      add(ReloadEvent());
    }
  }
}

class EditUsernameBloc extends EditBloc{
  EditUsernameBloc({required super.user, required super.userRepository});
}

class EditAvatarBloc extends EditBloc{
  EditAvatarBloc({required super.user, required super.userRepository});
}

class EditCoverImageBloc extends EditBloc{
  EditCoverImageBloc({required super.user, required super.userRepository});
}

class EditDescriptionBloc extends EditBloc{
  EditDescriptionBloc({required super.user, required super.userRepository});
}

class EditCityBloc extends EditBloc{
  EditCityBloc({required super.user, required super.userRepository});
}

class EditAddressBloc extends EditBloc{
  EditAddressBloc({required super.user, required super.userRepository});
}

class EditCountryBloc extends EditBloc{
  EditCountryBloc({required super.user, required super.userRepository});
}

class EditLinkBloc extends EditBloc{
  EditLinkBloc({required super.user, required super.userRepository});
}

