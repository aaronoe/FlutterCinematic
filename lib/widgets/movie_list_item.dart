import 'package:flutter/material.dart';
import 'package:movies_flutter/model/movie.dart';
import 'package:movies_flutter/widgets/movie_detail.dart';

class MovieListItem extends StatelessWidget {

  MovieListItem(this.movie);

  final Movie movie;

  Widget _getTitleSection() {
    var ratingColor = Color.lerp(
        Colors.red, Colors.green, movie.voteAverage / 10.0);

    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  child: new Text(
                    movie.title,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: new Text(
                    movie.releaseDate,
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                )
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.all(4.0),
            child: new Icon(
              Icons.star,
              color: ratingColor,
            ),
          ),
          new Text(movie.voteAverage.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          new PageRouteBuilder(
              transitionsBuilder: (context, animation, secondaryAnimation,
                  child) =>
              new FadeTransition(opacity: animation, child: child),
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return new MovieDetailWidget(movie);
              }),
        );
      },
      child: new Card(
        child: new Column(
          children: <Widget>[
            new Hero(
              child: new FadeInImage.assetNetwork(
                placeholder: "assets/placeholder.jpg",
                image: movie.getBackDropUrl(),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
                fadeInDuration: new Duration(milliseconds: 50),
              ),
              tag: "Movie-Tag-${movie.id}",
            ),
            _getTitleSection(),
          ],
        ),
      ),
    );
  }

}