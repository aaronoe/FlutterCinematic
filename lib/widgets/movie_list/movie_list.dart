import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/util/mediaproviders.dart';
import 'package:movies_flutter/widgets/movie_list/movie_list_item.dart';

// TODO: I should make this a StatefulWidget at some point
// and figure out the infinite scrolling
class MediaList extends StatelessWidget {
  final MediaProvider provider;
  final String category;

  MediaList(this.provider, this.category);

  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
      new GlobalKey<AsyncLoaderState>();
  final List<MediaItem> _movies = new List();
  int _pageNumber = 1;

  _loadNextPage() async {
    _pageNumber++;
    try {
      var nextMovies = await provider.loadMedia(category, page: _pageNumber);
      _movies.addAll(nextMovies);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
        key: _asyncLoaderState,
        initState: () async => await provider.loadMedia(category),
        renderLoad: () => new CircularProgressIndicator(),
        renderError: ([error]) =>
        new Text('Sorry, there was an error loading your movie'),
        renderSuccess: ({data}) {
          _movies.addAll(data);

          return new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index > (_movies.length * 0.7)) {
                  _loadNextPage();
                }

                return new MovieListItem(_movies[index]);
              });
        });

    return new Center(child: _asyncLoader);
  }
}