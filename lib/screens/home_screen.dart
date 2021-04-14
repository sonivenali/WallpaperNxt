import 'package:flutter/material.dart';
import 'package:wallpapernxt_app/models/models.dart';
import 'package:wallpapernxt_app/screens/search_result_screen.dart';
import 'package:wallpapernxt_app/service/service.dart';

import 'image_screen.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final service = WallpaperService();
  bool showSearch = false;
  final venali = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            FutureBuilder<List<WallpaperData>>(
                future: service.getHomeData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ImageScreen(
                                              snapshot.data[index].urls.small)));
                                },
                                child: Image.network(
                                  snapshot.data[index].urls.small,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ],
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Something went wrong!"));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                }),
            buildTopBar(),
            buildMenu(context)
          ],
        ),
      ),
    );
  }

  Positioned buildMenu(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 5,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Wrap(
                      children: [
                        Container(
                          color: Colors.black,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: [
                                    IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                          );
                                        }),
                                  ],
                                ),
                                Divider(color: Colors.grey),
                                buildFlatButton(context, "Nature"),
                                Divider(color: Colors.grey),
                                buildFlatButton(context, 'LandScape'),
                                Divider(color: Colors.grey),
                                buildFlatButton(context, 'Love'),
                                Divider(color: Colors.grey),
                                buildFlatButton(context, 'Food'),
                                Divider(color: Colors.grey),
                                buildFlatButton(context, 'Music'),
                                Divider(color: Colors.grey),
                                buildFlatButton(context, 'Animal'),
                                Divider(color: Colors.grey),
                                buildFlatButton(context, 'Rain'),
                                Divider(color: Colors.grey),
                                buildFlatButton(context, 'Happy'),
                                Divider(color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        ));
  }

  buildTopBar() {
    return Container(
      height: 50,
      color: Colors.black.withOpacity(.5),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              ),
            ),
            showSearch
                ? Expanded(
                    child: Padding(
                    padding: const EdgeInsets.only(
                      top: 3,
                      left: 8,
                      right: 8,
                    ),
                    child: TextField(
                        textAlign: TextAlign.center,
                        controller: venali,
                        maxLines: 1,
                        maxLength: 20,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          counterText: "",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        )),
                  ))
                : Container(),
            IconButton(
              onPressed: () {
                if (!showSearch) {
                  setState(() {
                    showSearch = true;
                  });
                } else {
                  if (venali.text.isNotEmpty) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchResultScreen(venali.text)));
                  }
                }
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlatButton buildFlatButton(BuildContext context, wallType) {
    return FlatButton(
      child: Text(
        wallType,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchResultScreen(wallType)));
      },
    );
  }
}
