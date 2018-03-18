import 'package:flutter/material.dart';
import 'package:movies_flutter/model/movie.dart';
import 'package:movies_flutter/util/navigator.dart';
import 'package:movies_flutter/util/styles.dart';
import 'package:movies_flutter/util/utils.dart';

class MovieListItem extends StatelessWidget {

  MovieListItem(this.movie);

  final Movie movie;

  Widget _getTitleSection() {
    return new Container(
      padding: const EdgeInsets.all(12.0),
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
                    getGenreString(movie.genreIds),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: captionStyle,
                  ),
                )
              ],
            ),
          ),
          new Container(width: 12.0,),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(movie.voteAverage.toString(), style: captionStyle,),
                  new Container(width: 4.0,),
                  new Icon(Icons.star, color: Colors.grey[700], size: 16.0,)
                ],
              ),
              new Container(height: 4.0,),
              new Row(
                children: <Widget>[
                  new Text(movie.getReleaseYear().toString(), style: captionStyle,),
                  new Container(width: 4.0,),
                  new Icon(Icons.date_range, color: Colors.grey[700], size: 16.0,)
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        goToMovieDetails(context, movie);
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