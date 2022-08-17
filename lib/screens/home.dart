
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
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


  @override
  Widget build(BuildContext context) {
    final imageList =[
      _imageItem("mywine"),
      _imageItem("wines"),
      _imageItem("mywine"),
      _imageItem("wines"),_imageItem("mywine"),_imageItem("wines"),_imageItem("mywine"),
      _imageItem("mywine"),_imageItem("wines"),_imageItem("mywine"),
      _imageItem("mywine"),_imageItem("wines"),_imageItem("mywine"),
      _imageItem("mywine"),_imageItem("wines"),_imageItem("mywine"),];
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 2,
        crossAxisCount: 3,
        children: imageList
    );
  }
  Widget _imageItem(String name) {
    var image = "images/" + name + ".jpg";
    return Container(
      child: Image.asset(image, fit: BoxFit.cover,),
    );
  }
  Future<void> _imagesPicking() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    print(images);
  }
}