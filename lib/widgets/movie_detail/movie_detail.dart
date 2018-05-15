import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/model/tvseason.dart';
import 'package:movies_flutter/scoped_models/app_model.dart';
import 'package:movies_flutter/util/api_client.dart';
import 'package:movies_flutter/util/mediaproviders.dart';
import 'package:movies_flutter/util/styles.dart';
import 'package:movies_flutter/util/utils.dart';
import 'package:movies_flutter/widgets/movie_detail/cast_section.dart';
import 'package:movies_flutter/widgets/movie_detail/meta_section.dart';
import 'package:movies_flutter/widgets/movie_detail/season_section.dart';
import 'package:movies_flutter/widgets/movie_detail/similar_section.dart';
import 'package:movies_flutter/widgets/utilviews/bottom_gradient.dart';
import 'package:movies_flutter/widgets/utilviews/text_bubble.dart';
import 'package:scoped_model/scoped_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final MediaItem _mediaItem;
  final MediaProvider provider;
  final ApiClient _apiClient = new ApiClient();

  MovieDetailScreen(this._mediaItem, this.provider);

  @override
  MovieDetailScreenState createState() {
    return new MovieDetailScreenState();
  }
}

class MovieDetailScreenState extends State<MovieDetailScreen> {
  List<Actor> _actorList;
  List<TvSeason> _seasonList;
  List<MediaItem> _similarMedia;
  dynamic _mediaDetails;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _loadCast();
    _loadDetails();
    _loadSimilar();
    if (widget._mediaItem.type == MediaType.show) _loadSeasons();

    new Timer(
        new Duration(milliseconds: 100), () => setState(() => _visible = true));
  }

  void _loadCast() async {
    try {
      List<Actor> cast = await widget.provider.loadCast(widget._mediaItem.id);
      setState(() => _actorList = cast);
    } catch (e) {}
  }

  void _loadDetails() async {
    try {
      dynamic details = await widget.provider.getDetails(widget._mediaItem.id);
      setState(() => _mediaDetails = details);
    } catch (e) {}
  }

  void _loadSeasons() async {
    try {
      List<TvSeason> seasons =
          await widget._apiClient.getShowSeasons(widget._mediaItem.id);
      setState(() => _seasonList = seasons);
    } catch (e) {}
  }

  void _loadSimilar() async {
    try {
      List<MediaItem> similar =
          await widget.provider.getSimilar(widget._mediaItem.id);
      setState(() => _similarMedia = similar);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: primary,
        body: new CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(widget._mediaItem),
            _buildContentSection(widget._mediaItem),
          ],
        ));
  }

  Widget _buildAppBar(MediaItem movie) {
    return new SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      actions: <Widget>[
        new ScopedModelDescendant<AppModel>(
            builder: (context, child, AppModel model) => new IconButton(
                icon: new Icon(model.isItemFavorite(widget._mediaItem)
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () => model.toggleFavorites(widget._mediaItem)))
      ],
      flexibleSpace: new FlexibleSpaceBar(
        background: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Hero(
              tag: "Movie-Tag-${widget._mediaItem.id}",
              child: new FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: "assets/placeholder.jpg",
                  image: widget._mediaItem.getBackDropUrl()),
            ),
            new BottomGradient(),
            _buildMetaSection(movie)
          ],
        ),
      ),
    );
  }

  Widget _buildMetaSection(MediaItem mediaItem) {
    return new AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: new Duration(milliseconds: 500),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new TextBubble(
                  mediaItem.getReleaseYear().toString(),
                  backgroundColor: new Color(0xffF47663),
                ),
                new Container(
                  width: 8.0,
                ),
                new TextBubble(mediaItem.voteAverage.toString(),
                    backgroundColor: new Color(0xffF47663)),
              ],
            ),
            new Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: new Text(mediaItem.title,
                  style: new TextStyle(
                      color: new Color(0xFFEEEEEE), fontSize: 20.0)),
            ),
            new Row(
              children: getGenresForIds(mediaItem.genreIds)
                  .sublist(0, min(5, mediaItem.genreIds.length))
                  .map((genre) => new Row(
                        children: <Widget>[
                          new TextBubble(genre),
                          new Container(
                            width: 8.0,
                          )
                        ],
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContentSection(MediaItem media) {
    return new SliverList(
      delegate: new SliverChildListDelegate(<Widget>[
        new Container(
          decoration: new BoxDecoration(color: const Color(0xff222128)),
          child: new Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "SYNOPSIS",
                  style: const TextStyle(color: Colors.white),
                ),
                new Container(
                  height: 8.0,
                ),
                new Text(media.overview,
                    style:
                        const TextStyle(color: Colors.white, fontSize: 12.0)),
                new Container(
                  height: 8.0,
                ),
              ],
            ),
          ),
        ),
        new Container(
          decoration: new BoxDecoration(color: primary),
          child: new Padding(
              padding: const EdgeInsets.all(16.0),
              child: _actorList == null
                  ? new Center(
                      child: new CircularProgressIndicator(),
                    )
                  : new CastSection(_actorList)),
        ),
        new Container(
          decoration: new BoxDecoration(color: primaryDark),
          child: new Padding(
              padding: const EdgeInsets.all(16.0),
              child: _mediaDetails == null
                  ? new Center(
                      child: new CircularProgressIndicator(),
                    )
                  : new MetaSection(_mediaDetails)),
        ),
        (widget._mediaItem.type == MediaType.show)
            ? new Container(
                decoration: new BoxDecoration(color: primary),
                child: new Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _seasonList == null
                        ? new Container()
                        : new SeasonSection(widget._mediaItem, _seasonList)),
              )
            : new Container(),
        new Container(
            decoration: new BoxDecoration(
                color: (widget._mediaItem.type == MediaType.movie
                    ? primary
                    : primaryDark)),
            child: _similarMedia == null
                ? new Container()
                : new SimilarSection(_similarMedia))
      ]),
    );
  }
}
