import 'dart:convert';

import 'package:http/http.dart';

Future<List<Album>> fetchAlbum() async {
  List<Album> albumList;
  final response = await get('http://151.72.232.10:5000/film/getall');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    albumList = (json.decode(response.body) as List)
        .map((i) => Album.fromJson(i))
        .toList();
    return albumList;
    //Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final String filmName;
  final String anno;
  final String regista;
  final String filmImageUrl;

  Album({this.filmName, this.anno, this.regista, this.filmImageUrl});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      filmName: json['film_name'],
      anno: json['film_year'],
      regista: json['film_director'],
      filmImageUrl: json['url'],
    );
  }
}
