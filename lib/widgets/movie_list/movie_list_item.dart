import 'package:flutter/material.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/util/navigator.dart';
import 'package:movies_flutter/util/utils.dart';

class MovieListItem extends StatelessWidget {
  MovieListItem(this.movie);

  final MediaItem movie;

  Widget _getTitleSection(BuildContext context) {
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: new Text(
                    getGenreString(movie.genreIds),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.body1,
                  ),
                )
              ],
            ),
          ),
          new Container(
            width: 12.0,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text(
                    movie.voteAverage.toString(),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  new Container(
                    width: 4.0,
                  ),
                  new Icon(
                    Icons.star,
                    size: 16.0,
                  )
                ],
              ),
              new Container(
                height: 4.0,
              ),
              new Row(
                children: <Widget>[
                  new Text(
                    movie.getReleaseYear().toString(),
                    style: Theme.of(context).textTheme.body1,
                  ),
                  new Container(
                    width: 4.0,
                  ),
                  new Icon(
                    Icons.date_range,
                    size: 16.0,
                  )
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
    return new Card(
      child: new InkWell(
        onTap: () => goToMovieDetails(context, movie),
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
            _getTitleSection(context),
          ],
        ),
      ),
    );
  }
}
