

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:facebook_auth/main.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:torch_light/torch_light.dart';



class CameraScreen extends StatefulWidget {
  /// Default Constructor
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        controller.setFlashMode(FlashMode.off);
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          bottom: true,
          top: true,
          child: Container(
            color: Colors.white,
            child:
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CameraPreview(controller),
                ),
                Column(
                  children: [
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          splashRadius: 20,
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {

                            final image = await controller.takePicture();
                            GallerySaver.saveImage(image.path, albumName: 'FacebookStudy')
                                .then((bool? value){
                                  if(value != null){
                                    if(value!){
                                      const SnackBar snackBar = SnackBar(
                                        content: Text('Lưu ảnh thành công'),
                                        duration: Duration(seconds: 1),
                                      );
                                      ScaffoldMessenger.of(context)
                                        ..hideCurrentMaterialBanner()
                                        ..showSnackBar(snackBar);
                                    }
                                  };
                                  print("Xuat Thong bao");
                                  const SnackBar snackBar = SnackBar(
                                    content: Text('Lưu ảnh thành công'),
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentMaterialBanner()
                                    ..showSnackBar(snackBar);
                            });
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Stack(
                            children: [
                              Container(
                                height: 75,
                                width: 75,
                                child: SizedBox(),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white,
                                  // border: Border.fromBorderSide(BorderSide(width: 8,color: AppTheme.grey500))
                                ),
                              ),
                              Positioned(
                                  top: 6,
                                  left: 6,
                                  child: Container(
                                    height: 63,
                                    width: 63,
                                    child: SizedBox(),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: AppTheme.grey500,
                                        border: Border.fromBorderSide(BorderSide(width: 3,color: Colors.black))
                                    ),
                                  )
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15,)
                  ],
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
