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
  FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    searchFocusNode = FocusNode();
  }

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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageScreen(
                                          snapshot.data[index].urls.full)));
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(
                                  snapshot.data[index].urls.small,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                Positioned(
                                  bottom: 3,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 28),
                                        child: Text(
                                          snapshot.data[index].user.username
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color:
                                                  Colors.white.withOpacity(1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data[index].user.totalLikes
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8, top: 6),
                                        child: Icon(Icons.favorite,
                                            size: 30, color: Colors.white60),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
                        focusNode: searchFocusNode,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "Search here..",
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.7)),
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
                  searchFocusNode.requestFocus();
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

  @override
  void dispose() {
    searchFocusNode.dispose();
    super.dispose();
  }
}
