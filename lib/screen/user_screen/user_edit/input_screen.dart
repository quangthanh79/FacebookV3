
import 'dart:io';

import 'package:facebook_auth/screen/user_screen/user_edit/user_edit_screen.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class InputScreen extends MyPage{
  @override
  State<StatefulWidget> createState() => InputScreenState();

  static void route({
    required BuildContext context,
    required String label,
    String value = "",
    void Function()? onBack,
    void Function(String?)? onBackResponse
  }) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InputScreen(
              label: label, value: value,
              onBack: onBack, onBackResponse: onBackResponse
            )
        )
    );
  }

  String label;
  String value;

  InputScreen({super.key, required this.label, this.value = "", super.onBack, super.onBackResponse});
}


class InputScreenState extends MyPageState<InputScreen>{
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.value != ""){
      controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                widget.response = null;
                back();
              },
            ),
            Expanded(
                flex: 1,
                child: ListView(
                    addAutomaticKeepAlives: true,
                    padding: const EdgeInsets.all(0),
                    children: [
                      Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.blue,
                                width: 1
                            ),
                          borderRadius: const BorderRadius.all(Radius.circular(8))
                        ),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            labelText: "Nhập ${widget.label}",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          maxLength: 120,
                          onSubmitted: (text){
                            controller.text = text;
                          },
                          maxLines: 4,
                          minLines: 2,
                        ),
                      ),
                      const SizedBox(height: 48,)
                    ]
                )
            ),
            Container(
              margin: const EdgeInsets.all(12),
              child: Row(children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      widget.response = controller.text;
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



