import 'package:flutter/material.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("アルバム"),
      ),
      body: const Center(
        child: Text("アルバム画面", style: TextStyle(fontSize: 32))),
    );
  }

}
