import 'package:flutter/material.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/scoped_models/app_model.dart';
import 'package:movies_flutter/widgets/movie_list/movie_list_item.dart';
import 'package:scoped_model/scoped_model.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Favorites"),
          bottom: new TabBar(
            tabs: [
              new Tab(
                icon: new Icon(Icons.movie),
              ),
              new Tab(
                icon: new Icon(Icons.tv),
              ),
            ],
          ),
        ),
        body: new ScopedModelDescendant<AppModel>(
          builder: (context, child, AppModel model) => new TabBarView(
                children: <Widget>[
                  new _FavoriteList(model.favoriteMovies),
                  new _FavoriteList(model.favoriteShows),
                ],
              ),
        ),
      ),
    );
  }
}

class _FavoriteList extends StatelessWidget {
  final List<MediaItem> _media;

  const _FavoriteList(this._media, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: _media.length,
        itemBuilder: (BuildContext context, int index) {
          return new MovieListItem(_media[index]);
        });
  }
}
