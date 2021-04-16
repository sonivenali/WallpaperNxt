import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

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
      body: Stack(
        children: [
          Center(
            child: Image.network(
              widget.imageLink,
            ),
          ),
          Positioned(
            bottom: 30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40,bottom: 40),
                child: IconButton(
                    icon: Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      try {
                        // Saved with this method.
                        var imageId = await ImageDownloader.downloadImage(
                            widget.imageLink);
                        if (imageId == null) {
                          return;
                        }
                      } on PlatformException catch (error) {
                        print(error);
                      }
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
