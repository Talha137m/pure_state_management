import 'dart:convert';
import 'package:http/http.dart' as http;

import 'album_model.dart';

abstract class ApiProvider {
  String baseUrl = 'https://jsonplaceholder.typicode.com/';
  String get apiUrl;
  String get url => baseUrl + apiUrl;
  dynamic fetch({String endPont = ''}) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return;
    }
  }
}

class AlbumProvider extends ApiProvider {
  static AlbumProvider? _albumProvider;
  AlbumProvider._interbnal();
  factory AlbumProvider() {
    return _albumProvider ??= AlbumProvider._interbnal();
  }
  Future<List<AlbumModelClass>> fetchAlbums() async {
    var data = await fetch() as List;
    var albums = data.map((e) => AlbumModelClass.fromMap(e)).toList();
    return albums;
  }

  @override
  String get apiUrl => 'albums';
}
