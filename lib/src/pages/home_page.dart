import 'package:flutter/material.dart';
import 'package:flutter_curso_peliculas/src/providers/peliculas.dart';
import 'package:flutter_curso_peliculas/src/widgets/card_swiper.dart';
import 'package:flutter_curso_peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Container(
        child: Column(
          children: [
            _swiperCards(context),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperCards(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: _screenSize.width * 0.85,
          child: Center(
            child: (snapshot.hasData)
                ? CardSwiper(peliculas: snapshot.data)
                : CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _footer(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Populares',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1, // subtitle1 - headline6
              ),
            ),
            SizedBox(
              height: _screenSize.height * 0.025,
            ),
            FutureBuilder(
                future: peliculasProvider.getPopular(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  snapshot.data?.forEach((e) {
                    print(e.title);
                  });

                  return (snapshot.hasData)
                      ? MovieHorizontal(peliculas: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                })
          ],
        ));
  }
}
