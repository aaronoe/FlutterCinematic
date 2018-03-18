import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:movies_flutter/model/movie.dart';
import 'package:movies_flutter/util/api_client.dart';
import 'package:movies_flutter/widgets/movie_list_item.dart';


class MovieList extends StatefulWidget {
  MovieList({Key key, this.title, this.category}) : super(key: key);

  final String title;
  final String category;

  @override
  _MovieListState createState() => new _MovieListState();
}

class _MovieListState extends State<MovieList> {

  var key = "de2c61fd451b50de11cee234a5d8346b";
  final GlobalKey<AsyncLoaderState> _asyncLoaderState =
  new GlobalKey<AsyncLoaderState>();

  List<Movie> _movies;
  int _pageNumber = 1;

  _loadNextPage() async {
    _pageNumber++;
    try {
      var nextMovies = await ApiClient.get().pollMovies(page: _pageNumber);
      _movies.addAll(nextMovies);
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = new AsyncLoader(
        key: _asyncLoaderState,
        initState: () async =>
        await ApiClient.get().pollMovies(category: this.widget.category),
        renderLoad: () => new CircularProgressIndicator(),
        renderError: ([error]) =>
        new Text('Sorry, there was an error loading your movie'),
        renderSuccess: ({data}) {
          _movies = data;

          return new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                if (index > (_movies.length * 0.7)) {
                  _loadNextPage();
                }

                return new MovieListItem(_movies[index]);
              });
        }
    );

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.title),
        ),
        body: new Center(
            child: _asyncLoader
        )
    );
  }
}