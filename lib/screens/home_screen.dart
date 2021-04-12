import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            ListView(),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 30,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
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
                                                onPressed: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => Homepage()),
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
                ))
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
      onPressed: () => Navigator.pop(context),
    );
  }
}
