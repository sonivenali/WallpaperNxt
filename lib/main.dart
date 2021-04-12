import 'package:flutter/material.dart';
import 'package:wallpapernxt_app/screens/home_screen.dart';

void main() {
  runApp(WallpaperNxt());
}

class WallpaperNxt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}
