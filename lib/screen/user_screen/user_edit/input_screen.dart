
import 'dart:io';

import 'package:facebook_auth/screen/user_screen/user_edit/user_edit_screen.dart';
import 'package:flutter/material.dart';


class InputScreen extends StatefulWidget with MyPage{
  @override
  State<StatefulWidget> createState() => InputScreenState();

  static void show({
    required BuildContext context,
    required UserEditScreen main,
    required String label,
    String value = "",
    void Function()? callback
  }) async {
    main.output = null;
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InputScreen(main: main, label: label, value: value, callback: callback,)
        )
    );
  }

  UserEditScreen main;
  String label;
  String value;
  void Function()? callback;

  InputScreen({super.key, required this.main, required this.label, this.value = "", this.callback});
}


class InputScreenState extends State<InputScreen>{

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.value != ""){
      controller.text = widget.value;
    }
  }

  Future<void> save() async {
    widget.main.output = controller.text;
    if (widget.callback != null){
      widget.callback!();
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.context = context;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'OpenSans', platform: TargetPlatform.iOS, backgroundColor: Colors.black12),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 28),
            Header(
              label: "Chỉnh sửa ${widget.label}",
              main: widget,
            ),
            Expanded(
                flex: 1,
                child: ListView(
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
                          onTap: (){
                            print("Tab textfield");
                          },
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
                      save();
                      widget.back();
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



