import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  final String imageLink;

  ImageScreen(this.imageLink);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
          child: Image.network(
        widget.imageLink,
      )),
    );
  }
}
