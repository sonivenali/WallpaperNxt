import 'dart:convert';

import 'package:http/http.dart' as http;

class WallpaperService {
  getHomeData() async {
    final resposne = await http.get(
        "https://api.unsplash.com/photos/?client_id=0yNajGjBIQe2N7mhhcASa4bpUzs3OLK5pn5vRDnWt4c&order_by=latest&per_page=10&page=1");
    final data = json.decode(resposne.body);
    List<WallpaperService> items = [];
    for (Map<String, dynamic> u in data) {
      items.add(WallpaperService.fromJson(u));
    }
    return items;
  }

}
