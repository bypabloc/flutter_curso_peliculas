import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:flutter_curso_peliculas/src/models/cast.dart';

class CastProvider {
  String _apiKey = '6bd065d775174c013388d12a40c93062';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _page = 0;
  bool _cargando = false;

  List<Cast> _populares = [];

  final _popularesStreamController = StreamController<List<Cast>>.broadcast();

  Function(List<Cast>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Cast>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Actor>> _procesarUri(Uri uri) async {
    var response = [];
    try {
      final resp = await http.get(uri);
      if (resp.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(resp.body);
        final cast = Cast.fromJsonList(jsonResponse['cast']);

        response = cast.actores;
      } else {
        print('Request failed with status: ${resp.statusCode}.');
      }
    } catch (err) {
      print(err);
    }

    return response;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final uri = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    return await _procesarUri(uri);
  }
}
