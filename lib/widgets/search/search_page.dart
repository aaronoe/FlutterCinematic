import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:movies_flutter/model/searchresult.dart';
import 'package:movies_flutter/util/api_client.dart';
import 'package:movies_flutter/widgets/search/search_item.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchScreen> {

  ApiClient _apiClient = ApiClient.get();
  List<SearchResult> _resultList;
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
      List<SearchResult> searchResults = await _apiClient.getSearchResults(text);
      if (searchResults != null) setState(() => _resultList = searchResults);
    } catch (Exception) {}
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: searchBar.build(context),
        body: (_resultList == null || _resultList.length == 0)
            ? new Center(child: new Text("Search for movies, shows and actors"))
            : new ListView.builder(
            itemCount: _resultList.length,
            itemBuilder: (BuildContext context, int index) =>
            new SearchItemCard(_resultList[index])
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
