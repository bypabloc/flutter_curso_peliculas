import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:flutter_curso_peliculas/src/models/pelicula.dart';

class PeliculasProvider {
  String _apiKey = '6bd065d775174c013388d12a40c93062';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Pelicula> _populares = [];

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarUri(Uri uri) async {
    var response = [];
    try {
      final resp = await http.get(uri);
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

  Future<List<Pelicula>> getEnCines() async {
    final uri = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _procesarUri(uri);
  }

  Future<List<Pelicula>> getPopular() async {
    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    final uri = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final resp = await _procesarUri(uri);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;

    return resp;
  }
}
