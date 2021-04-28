import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:flutter_curso_peliculas/src/models/pelicula.dart';

class PeliculasProvider {
  String _apiKey = '6bd065d775174c013388d12a40c93062';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    var response = [];
    try {
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(resp.body);
        final peliculas = Peliculas.fromJsonList(jsonResponse['results']);

        response = peliculas.items;
      } else {
        print('Request failed with status: ${resp.statusCode}.');
      }
    } catch (err) {
      print(err);
    }

    return response;
  }

  Future<List<Pelicula>> getPopular() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
    });

    var response = [];
    try {
      final resp = await http.get(url);
      if (resp.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(resp.body);
        final peliculas = Peliculas.fromJsonList(jsonResponse['results']);

        response = peliculas.items;
      } else {
        print('Request failed with status: ${resp.statusCode}.');
      }
    } catch (err) {
      print(err);
    }

    return response;
  }
}
