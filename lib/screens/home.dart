import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../models/DisplayImage.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Search'),
      ),
      body:
      ImagesWidget(),
    );
  }
}
class ImagesWidget extends StatefulWidget {
  const ImagesWidget({Key? key}) : super(key: key);

  @override
  State<ImagesWidget> createState() => _ImagesWidgetState();
}

class _ImagesWidgetState extends State<ImagesWidget> {
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  List<String> _permanentImagePathList = [];
  List<File>? _permanentImageFileList = [];
  List<DisplayImage>? _displayImageList = [];

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    if (_displayImageList?.length != null ) {
      if (_displayImageList?.length == 0) {
        print("選択されている画像がないとき。");
        return Scaffold(
          body:
          Center(
            child: Text("画像を選択してください", style: TextStyle(fontSize: 32)),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton:FloatingActionButton(
            onPressed: _imagesPicking,
            child: Icon(Icons.add),
          ),
        );
      }
      return Scaffold(
        body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 2,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
            ),
            itemCount: _displayImageList?.length,
            itemBuilder: (context, index) {
              return Stack(
                  children:[
                    Positioned.fill(child: Container(
                        child: Image.file(
                          File(_displayImageList![index].file.path), fit: BoxFit.cover,)
                    )),
                    Positioned(
                        right: 2,
                        child: (_displayImageList![index].uploaded)?Icon(Icons.check_circle):Icon(Icons.highlight_off))]
              );}
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: _imagesPicking,
          child: Icon(Icons.add),
        ),
      );
    } else {
        //ユーザが画像を選択せずに戻った場合。
        return Scaffold(
          body:
          Center(
            child: Text("画像を選択してください", style: TextStyle(fontSize: 32)),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton:FloatingActionButton(
            onPressed: _imagesPicking,
            child: Icon(Icons.add),
          ),
        );
    }
  }

  Future<void> _imagesPicking() async {
    try {
      final List<XFile>? pickedFileList = await _picker.pickMultiImage();
      // getUrl();
      // _handleUploadImage(pickedFileList);
      if(pickedFileList != null) {
        saveImagePermanentHandle(pickedFileList);
      }
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }
  Future<void> _handleUploadImage() async {
    _displayImageList!.forEach((element) async {
      if (element.uploaded != false) {

      }
    });
  }

  Future<void> saveImagePermanentHandle(List<XFile> pickedFileList) async {
    pickedFileList.forEach((element) async {
      DateTime created = await element.lastModified();
      _displayImageList!.add(DisplayImage(File(element.path), false, created));
    });
    _handleUploadImage();
    setState(() {
      _displayImageList;
    });
  }
  //とりあえず使わない。pathを永続化するためのメソッド
  // Future<void> saveImagePermanent(String imagePath) async {
  //   final directory = await getExternalStorageDirectory();
  //   final permanentPath = '${directory!.path}/$imagePath';
  //   final image = File(permanentPath);
  //   if (_permanentImagePathList.contains(permanentPath)) {
  //     return null;
  //   }
  //   final savedImage = await File(imagePath).copy(image.path);
  //   setState(() {
  //     _permanentImageFileList!.add(savedImage);
  //   });
  // }
}