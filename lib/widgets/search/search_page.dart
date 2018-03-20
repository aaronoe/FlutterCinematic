import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/util/api_client.dart';
import 'package:movies_flutter/widgets/movie_list/movie_list_item.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchScreen> {

  ApiClient _apiClient = ApiClient.get();
  List<MediaItem> _resultList;
  SearchBar searchBar;

  _SearchPageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        buildDefaultAppBar: _buildAppBar,
        onSubmitted: _onSubmitted
    );
  }

  void _onSubmitted(String text) async {
    try {
      List<MediaItem> movies = await _apiClient.getSearchResults(text);
      if (movies != null) setState(() => _resultList = movies);
    } catch (Exception) {}
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: searchBar.build(context),
        body: (_resultList == null || _resultList.length == 0)
            ? new Center(child: new Text("Enter your query"))
            : new ListView.builder(
            itemCount: _resultList.length,
            itemBuilder: (BuildContext context, int index) =>
            new MovieListItem(_resultList[index])
        )
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Search Movies'),
        actions: [searchBar.getSearchAction(context)]
    );
  }

}
