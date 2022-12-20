
import 'dart:io';

import 'package:facebook_auth/screen/user_screen/user_edit/user_edit_screen.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


// ignore: must_be_immutable
class InputCoverImageScreen extends MyPage{
  // response is a image file
  @override
  State<StatefulWidget> createState() => InputCoverImageScreenState();

  static void route({
    required BuildContext context,
    required String label,
    String? value,
    void Function()? onBack,
    void Function(dynamic)? onBackResponse
  }) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InputCoverImageScreen(
                label: label, value: value,
                onBack: onBack, onBackResponse: onBackResponse
            )
        )
    );
  }

  String label; // label of field
  String? value; // current value of field

  InputCoverImageScreen({super.key, required this.label, this.value = "", super.onBack, super.onBackResponse});
}


class InputCoverImageScreenState extends MyPageState<InputCoverImageScreen>{
  ImagePicker imagePicker = ImagePicker();
  File? fileResponse;

  @override
  void initState() {
    super.initState();
  }

  Future<void> chooseImage({required ImageSource imageSource}) async{
    XFile? file = await imagePicker.pickImage(source: imageSource);
    if (file != null) {
      // print(file.path);
      setState(() {
        File file2 = File(file.path);
        widget.response = file2;
        // print(file2.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'OpenSans', platform: TargetPlatform.iOS, backgroundColor: Colors.black12),
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 28),
              Header(
                label: "Chỉnh sửa ${widget.label}",
                back: () {
                  widget.response = null;  // not return response
                  back();
                },
              ),
              Expanded(
                  flex: 1,
                  child: ListView(
                      addAutomaticKeepAlives: true,
                      padding: const EdgeInsets.all(0),
                      children: [
                        const SizedBox(height: 100,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(15),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue, width: 5)
                              ),
                              child: GestureDetector(
                                  onTap: (){ chooseImage(imageSource: ImageSource.gallery); },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: getImage(
                                        file: widget.response,
                                        uri: widget.value,
                                        defaultUri: 'assets/images/default_cover_image.jpg',
                                        width: 1000,
                                        height: 220
                                    ),
                                  )
                              ),
                            )
                          ],
                        )
                      ]
                  )
              ),
              Container(
                  margin: const EdgeInsets.all(12),
                  child: Row(children: [
                    Expanded(
                        child: GestureDetector(
                          onTap: (){
                            back();
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                color: Colors.blue,
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Lưu",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18
                                ),
                              )
                          ),
                        )
                    )
                  ])
              )
            ],
          ),
        )
    );
  }
}



