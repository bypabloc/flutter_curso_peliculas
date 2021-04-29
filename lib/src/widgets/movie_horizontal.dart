import 'package:flutter/material.dart';
import 'package:flutter_curso_peliculas/src/models/pelicula.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.25,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _cards(context),
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _card(context, peliculas[i]),
      ),
    );
  }

  Widget _card(BuildContext context, Pelicula e) {
    final _screenSize = MediaQuery.of(context).size;

    e.uniqueId = '${e.id}-card';

    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: e.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(e.getPosterImg()),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.21,
              ),
            ),
          ),
          SizedBox(
            height: _screenSize.height * 0.01,
          ),
          Container(
            height: _screenSize.height * 0.03,
            child: Text(
              e.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: e);
      },
    );
  }

  /*
  List<Widget> _cards(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return peliculas.map((e) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(e.getPosterImg()),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.21,
              ),
            ),
            SizedBox(
              height: _screenSize.height * 0.01,
            ),
            Container(
              height: _screenSize.height * 0.03,
              child: Text(
                e.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
            )
          ],
        ),
      );
    }).toList();
  }
  */
}
