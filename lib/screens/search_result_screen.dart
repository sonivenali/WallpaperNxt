import 'package:flutter/material.dart';
import 'package:wallpapernxt_app/models/models.dart';
import 'package:wallpapernxt_app/screens/image_screen.dart';
import 'package:wallpapernxt_app/service/service.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchQuery;

  SearchResultScreen(this.searchQuery);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  final service = WallpaperService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            FutureBuilder<List<WallpaperData>>(
                future: service.getSearchData(widget.searchQuery),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              GestureDetector(onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ImageScreen(snapshot.data[index].urls.full)));
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
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(.5),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
