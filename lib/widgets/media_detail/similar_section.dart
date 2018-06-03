import 'package:flutter/material.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/util/navigator.dart';


class SimilarSection extends StatelessWidget {
  final List<MediaItem> _similarMovies;

  SimilarSection(this._similarMovies);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Text(
            "Similar", style: new TextStyle(color: Colors.white),),
        ),
        new Container(
          height: 300.0,
          child: new GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            scrollDirection: Axis.horizontal,
            children: _similarMovies.map((MediaItem movie) =>
            new GestureDetector(
              onTap: () => goToMovieDetails(context, movie),
              child: new FadeInImage.assetNetwork(
                image: movie.getPosterUrl(),
                placeholder: 'assets/placeholder.jpg',
                height: 150.0,
                fit: BoxFit.cover,),
            )
            ).toList(),
          ),
        )
      ],
    );
  }
}