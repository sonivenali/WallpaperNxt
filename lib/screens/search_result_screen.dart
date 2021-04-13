import 'package:flutter/material.dart';
import 'package:wallpapernxt_app/models/models.dart';
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
    return Scaffold(
      body: FutureBuilder<List<WallpaperData>>(
          future: service.getSearchData(widget.searchQuery),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Image.network(
                          snapshot.data[index].urls.small,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitWidth,
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
    );
  }
}
