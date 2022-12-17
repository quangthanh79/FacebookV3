


import 'package:facebook_auth/screen/user_screen/user_edit/edit_bloc/edit_bloc.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_bloc/edit_event.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/edit_bloc/edit_state.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/input_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_edit/user_edit_screen.dart';
import 'package:facebook_auth/screen/user_screen/user_screen_components/menu_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class EditDescription extends StatelessWidget{
  UserEditScreenState main;
  BuildContext? context;

  EditDescription({super.key, required this.main});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
        margin: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => main.blocSystem.descriptionBloc.add(ReloadEvent()),
                  child: const Text(
                      "Tiểu sử",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20
                      )
                  ),
                ),
                GestureDetector(
                    onTap: (){ onChangeDescription(); },
                    child: Text(
                      main.user.description == null ? "Thêm" : "Chỉnh sửa",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.blue.shade700
                      ),
                    )
                )
              ],
            ),
            const SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                      onTap: (){ onChangeDescription(); },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Text(
                                main.user.description ?? "Thêm tiểu sử của bạn",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: main.user.description != null ? Colors.black : Colors.black38
                                ),
                              )
                            )
                          ]
                      )
                  ),
                )
              ],
            ),
            const SizedBox(height: 16,),
            MyDivider()
          ],
        )
    );
  }

  void onChangeDescription(){
    if (main.user.description != null){
      EditMenuBottom.showBottomMenu(
          context: context!,
          onEdit: changeDescription,
          onRemove: removeDescription,
          label: "Mô tả bản thân"
      );
    } else {
      changeDescription();
    }
  }

  void changeDescription() async{
    InputScreen.route(
        context: context!,
        label: "Tiểu sử",
        value: main.user.description ?? "",
        onBackResponse: (response){
          if (response != null){
            main.isChanged = true;
            main.user.description = response;
            main.blocSystem.descriptionBloc.commit(main.tempUser);
          }
        }
    );
  }

  void removeDescription(){
    main.user.description = "";
    main.blocSystem.descriptionBloc.commit(main.tempUser);
  }

}



// ignore: must_be_immutable
class EditInformation extends StatelessWidget{
  UserEditScreenState main;
  BuildContext? context;

  EditInformation({super.key, required this.main});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
        margin: const EdgeInsets.only(
            top: 12,
            left: 12,
            right: 12
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Chi tiết",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20
                  )
                ),
              ],
            ),
            const SizedBox(height: 16,),
            BlocBuilder<EditCityBloc, EditState>(
                builder: (context, state){
                  return getItem(
                      icon: Icons.home_repair_service,
                      label: main.user.city != null ? "" : "Thêm thành phố",
                      value: main.user.city,
                      function: onChangeCity
                  );
                }
            ),
            BlocBuilder<EditAddressBloc, EditState>(
                builder: (context, state){
                  return getItem(
                      icon: Icons.home,
                      label: main.user.address != null ? "Sống tại " : "Thêm địa chỉ",
                      value: main.user.address,
                      function: onChangeAddress
                  );
                }
            ),
            BlocBuilder<EditCountryBloc, EditState>(
                builder: (context, state){
                  return getItem(
                      icon: Icons.location_on,
                      label: main.user.country != null ? "Đến từ " : "Thêm quê quán",
                      value: main.user.country,
                      function: onChangeCountry
                  );
                }
            ),
            BlocBuilder<EditLinkBloc, EditState>(
                builder: (context, state){
                  return getItem(
                      icon: Icons.link_rounded,
                      label: main.user.link != null ? "" : "Thêm liên kết mạng xã hội",
                      value: main.user.link,
                      function: onChangeLink
                  );
                }
            ),
            getItem(
                icon: Icons.access_time_filled_sharp,
                label: "Tham gia vào ",
                value: main.user.join
            ),
            getItem(
                icon: Icons.person,
                label: "Có ",
                value: "${main.user.listing ?? 0} bạn bè"
            ),
            const SizedBox(height: 16,),
            MyDivider()
          ],
        )
    );
  }

  void onChangeCity(){
    if (main.user.city != null){
      EditMenuBottom.showBottomMenu(
          context: context!,
          onEdit: changeCity,
          onRemove: removeCity,
          label: "Thành phố"
      );
    } else {
      changeCity();
    }
  }
  void changeCity(){
    InputScreen.route(
        context: context!,
        label: "Thành phố sinh sống",
        value: main.user.city ?? "",
        onBackResponse: (response){
          if (response != null){
            main.isChanged = true;
            main.user.city = response;
            main.blocSystem.cityBloc.commit(main.tempUser);
          }
        }
    );
  }
  void removeCity(){
    main.user.city = "";
    main.blocSystem.cityBloc.commit(main.tempUser);
  }

  void onChangeAddress(){
    if (main.user.address != null){
      EditMenuBottom.showBottomMenu(
          context: context!,
          onEdit: changeAddress,
          onRemove: removeAddress,
          label: "Địa chỉ"
      );
    } else {
      changeAddress();
    }
  }
  void changeAddress(){
    InputScreen.route(
        context: context!,
        label: "Địa chỉ hiện tại",
        value: main.user.address ?? "",
        onBackResponse: (response){
          if (response != null){
            main.isChanged = true;
            main.user.address = response;
            main.blocSystem.addressBloc.add(CommitChangeEvent());
          }
        }
    );
  }
  void removeAddress(){
    main.user.address = "";
    main.blocSystem.addressBloc.add(CommitChangeEvent());
  }

  void onChangeCountry(){
    if (main.user.country != null){
      EditMenuBottom.showBottomMenu(
          context: context!,
          onEdit: changeCountry,
          onRemove: removeCountry,
          label: "Quê quán"
      );
    } else {
      changeCountry();
    }
  }
  void changeCountry(){
    InputScreen.route(
        context: context!,
        label: "Quê quán",
        value: main.user.country ?? "",
        onBackResponse: (response){
          if (response != null){
            main.isChanged = true;
            main.user.country = response;
            main.blocSystem.countryBloc.commit(main.tempUser);
          }
        }
    );
  }
  void removeCountry(){
    main.user.country = "";
    main.blocSystem.countryBloc.commit(main.tempUser);
  }

  void onChangeLink(){
    if (main.user.link != null){
      EditMenuBottom.showBottomMenu(
          context: context!,
          onEdit: changeLink,
          onRemove: removeLink,
          label: "Liên kết xã hội"
      );
    } else {
      changeLink();
    }
  }
  void changeLink(){
    InputScreen.route(
        context: context!,
        label: "Liên kết xã hội",
        value: main.user.link ?? "",
        onBackResponse: (response){
          if (response != null){
            main.isChanged = true;
            main.user.link = response;
            main.blocSystem.linkBloc.commit(main.tempUser);
          }
        }
    );
  }
  void removeLink(){
    main.user.link = "";
    main.blocSystem.linkBloc.commit(main.tempUser);
  }

  Widget getItem({
    String? label = "",
    String? value = "",
    IconData? icon = Icons.add,
    void Function()? function
  }){
    return RawMaterialButton(
      onPressed: function ?? (){},
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey,),
              const SizedBox(width: 8,),
              Expanded(
                  child: GestureDetector(
                    onTap: function ?? (){},
                    child: Text.rich(TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: label ?? "",
                            style: const TextStyle(
                                fontSize: 15
                            )
                        ),
                        TextSpan(
                            text: value ?? "",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ],
                    )),
                  )
              ),
              const SizedBox(width: 8,),
              function != null ? SizedBox(
                width: 30,
                child: GestureDetector(
                  onTap: function,
                  child: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ) : Container()
            ],
          )
      ),
    );
  }

}



