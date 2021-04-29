import 'package:flutter/material.dart';
import 'package:flutter_curso_peliculas/src/models/pelicula.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final orientation =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? 'portrait'
            : 'landscape';

    double width = (orientation == 'portrait') ? 0.5 : 0.18;

    // MediaQuery.of(context).orientation

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: new Swiper(
        layout: SwiperLayout.STACK,
        // itemWidth: _screenSize.width * 0.7,
        itemWidth: _screenSize.width * width,
        itemHeight: 1000,
        itemBuilder: (BuildContext context, int index) {
          final e = peliculas[index];
          return Hero(
            tag: e.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(e.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
