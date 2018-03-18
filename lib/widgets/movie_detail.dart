import 'package:flutter/material.dart';
import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/movie.dart';
import 'package:movies_flutter/util/api_client.dart';
import 'package:movies_flutter/util/styles.dart';
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
            _buildContentSection(_movie)
          ],
        )
    );
  }

  Widget _buildAppBar(Movie movie) {
    return new SliverAppBar(
      expandedHeight: 220.0,
      pinned: true,
      floating: true,
      flexibleSpace: new FlexibleSpaceBar(
        background: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Hero(
              tag: "Movie-Tag-${_movie.id}",
              child: new FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  height: 180.0,
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
                      AsyncSnapshot<List<CastMember>> snapshot) {
                    return snapshot.hasData
                        ? new CastSection(snapshot.data)
                        : new Text("Not Toll");
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

  final List<CastMember> _cast;

  CastSection(this._cast);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text("Cast", style: new TextStyle(color: Colors.white),),
        new Container(height: 8.0,),
        _buildCastCard(_cast[0]),
        /*
        new Expanded(
          child: new Container(
            height: 140.0,
            child: new CustomScrollView(
              scrollDirection: Axis.horizontal,
              slivers: <Widget>[
                new SliverFixedExtentList(
                    delegate: new SliverChildBuilderDelegate(
                            (context, index) => _buildCastCard(_cast[index])
                    ),
                    itemExtent: 140.0
                )
              ],
            ),
          ),
        )
        new ListView.builder(
            itemCount: _cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              CastMember actor = _cast[index];
              return _buildCastCard(actor);
            }
        )
        */
      ],
    );
  }

  _buildCastCard(CastMember actor) {
    return new Container(
      height: 140.0,
      width: 100.0,
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new FadeInImage.assetNetwork(
            placeholder: 'assets/placeholder.jpg',
            image: actor.getProfilePicture(),
            fit: BoxFit.cover,
            height: 140.0,
            width: 100.0,
          ),
          new BottomGradient.noOffset(),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(actor.name, style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 10.0),),
                new Container(height: 4.0,),
                new Row(
                  children: <Widget>[
                    new Icon(Icons.person, color: salmon, size: 10.0,),
                    new Container(width: 4.0,),
                    new Text(actor.character, softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 8.0)
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}

class BottomGradient extends StatelessWidget {

  final double offset;

  BottomGradient({this.offset: 0.95});

  BottomGradient.noOffset() : offset = 1.0;

  @override
  Widget build(BuildContext context) {
    return new DecoratedBox(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
            end: const FractionalOffset(0.0, 0.0),
            begin: new FractionalOffset(0.0, offset),
            colors: const <Color>[
              const Color(0xff222128),
              const Color(0x442C2B33),
              const Color(0x002C2B33)
            ],
          )
      ),
    );
  }
}

