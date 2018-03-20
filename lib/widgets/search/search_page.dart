import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchScreen> {

  SearchBar searchBar;
  String query;

  _SearchPageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        buildDefaultAppBar: _buildAppBar,
        onSubmitted: _onSubmitted
    );
  }

  void _onSubmitted(String text) {
    setState(() => query = text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      body: query == null
          ? new Center(child: new Text("Enter your query"))
          : new Center(child: new Text("Query: $query"),),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Search Movies'),
        actions: [searchBar.getSearchAction(context)]
    );
  }

}
