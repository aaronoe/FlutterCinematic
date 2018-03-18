import 'package:flutter/material.dart';
import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/movie.dart';
import 'package:movies_flutter/util/api_client.dart';
import 'package:movies_flutter/util/styles.dart';
import 'package:movies_flutter/widgets/bottom_gradient.dart';
import 'package:movies_flutter/widgets/cast_card.dart';
import 'package:movies_flutter/widgets/meta_section.dart';
import 'package:movies_flutter/widgets/text_bubble.dart';


class MovieDetailWidget extends StatelessWidget {

  final Movie _movie;
  final ApiClient _apiClient = ApiClient.get();

  MovieDetailWidget(this._movie);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: primary,
        body: new CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(_movie),
            _buildContentSection(_movie),
          ],
        )
    );
  }

  Widget _buildAppBar(Movie movie) {
    return new SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      flexibleSpace: new FlexibleSpaceBar(
        background: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Hero(
              tag: "Movie-Tag-${_movie.id}",
              child: new FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: double.INFINITY,
                  placeholder: "assets/placeholder.jpg",
                  image: _movie.getBackDropUrl()),
            ),
            new BottomGradient(),
            _buildMetaSection(movie)
          ],
        ),
      ),
    );
  }


  Widget _buildMetaSection(Movie movie) {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new TextBubble(movie.getReleaseYear().toString(),
                backgroundColor: new Color(0xffF47663),),
              new Container(width: 8.0,),
              new TextBubble(movie.voteAverage.toString(),
                  backgroundColor: new Color(0xffF47663)),
            ],
          ),
          new Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: new Text(movie.title,
                style: new TextStyle(
                    color: new Color(0xFFEEEEEE), fontSize: 20.0)),
          ),
          new Row(
            children: <Widget>[
              new TextBubble("Animation"),
              new Container(width: 8.0,),
              new TextBubble("Adventure"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildContentSection(Movie movie) {
    return new SliverList(
      delegate: new SliverChildListDelegate(
          <Widget>[
            new Container(
              decoration: new BoxDecoration(color: const Color(0xff222128)),
              child: new Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 8.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "SYNOPSIS", style: const TextStyle(color: Colors.white),),
                    new Container(height: 8.0,),
                    new Text(movie.overview, style: const TextStyle(
                        color: Colors.white, fontSize: 12.0)),
                    new Container(height: 8.0,),
                  ],
                ),
              ),
            ),
            new Container(
              decoration: new BoxDecoration(color: primary),
              child: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new FutureBuilder(
                  future: _apiClient.getMovieCredits(movie.id),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Actor>> snapshot) {
                    return snapshot.hasData
                        ? new CastSection(snapshot.data)
                        : new Center(child: new CircularProgressIndicator());
                  },
                ),
              ),
            ),
            new Container(
              decoration: new BoxDecoration(color: primaryDark),
              child: new Padding(
                padding: const EdgeInsets.all(16.0),
                child: new FutureBuilder(
                  future: _apiClient.getMovieDetails(movie.id),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? new MetaSection(snapshot.data)
                        : new Center(child: new CircularProgressIndicator());
                  },
                ),
              ),
            )
          ]
      ),
    );
  }

}

class CastSection extends StatelessWidget {

  final List<Actor> _cast;

  CastSection(this._cast);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text("Cast", style: new TextStyle(color: Colors.white),),
        new Container(height: 8.0,),
        new Container(
          height: 140.0,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: _cast.map((Actor actor) =>
            new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: new CastCard(actor),
            )
            ).toList(),
          ),
        )
      ],
    );
  }

}
