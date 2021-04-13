import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpapernxt_app/models/models.dart';

class WallpaperService {
  Future<List<WallpaperData>> getHomeData() async {
    final resposne = await http.get(
        "https://api.unsplash.com/photos/?client_id=0yNajGjBIQe2N7mhhcASa4bpUzs3OLK5pn5vRDnWt4c&order_by=latest&per_page=50&page=1");
    final data = json.decode(resposne.body);
    List<WallpaperData> items = [];
    for (Map<String, dynamic> u in data) {
      items.add(WallpaperData.fromJson(u));
    }
    return items;
  }

  Future<List<WallpaperData>> getSearchData(String query) async {
    final resposne = await http.get(
        "https://api.unsplash.com/search/photos/?client_id=0yNajGjBIQe2N7mhhcASa4bpUzs3OLK5pn5vRDnWt4c&query=$query&per_page=50&page=1");
    final data = json.decode(resposne.body);
    List<WallpaperData> items = [];
    for (Map<String, dynamic> u in data['results']) {
      items.add(WallpaperData.fromJson(u));
    }
    return items;
  }
}
