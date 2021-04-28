import 'package:flutter/material.dart';
import 'package:flutter_curso_peliculas/src/models/pelicula.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    final title = pelicula?.title != null ? pelicula.title : '';

    return Scaffold(
      body: Center(
        child: Text(title),
      ),
    );
  }
}
