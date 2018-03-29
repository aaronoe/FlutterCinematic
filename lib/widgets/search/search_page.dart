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
  List<SearchResult> _resultList = new List();
  SearchBar searchBar;
  LoadingState _currentState = LoadingState.WAITING;

  _SearchPageState() {
    searchBar = new SearchBar(
        inBar: false,
        setState: setState,
        buildDefaultAppBar: _buildAppBar,
        onSubmitted: _onSubmitted);
  }

  void _onSubmitted(String text) async {
    setState(() {
      _currentState = LoadingState.LOADING;
      _resultList.clear();
    });
    try {
      List<SearchResult> searchResults =
          await _apiClient.getSearchResults(text);
      if (searchResults != null) {
        setState(() {
          _currentState = LoadingState.DONE;
          _resultList = searchResults;
        });
      } else {
        _setErrorState();
      }

    } catch (Exception) {
      _setErrorState();
    }
  }

  void _setErrorState() => setState(() => _currentState = LoadingState.ERROR);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: searchBar.build(context), body: _buildContentSection());
  }

  Widget _buildContentSection() {
    switch (_currentState) {
      case LoadingState.WAITING:
        return new Center(
            child: new Text("Search for movies, shows and actors"));
      case LoadingState.ERROR:
        return new Center(child: new Text("An error occured"));
      case LoadingState.LOADING:
        return new Center(
          child: new CircularProgressIndicator(),
        );
      case LoadingState.DONE:
        return (_resultList == null || _resultList.length == 0)
            ? new Center(
                child:
                    new Text("Unforunately there aren't any matching results!"))
            : new ListView.builder(
                itemCount: _resultList.length,
                itemBuilder: (BuildContext context, int index) =>
                    new SearchItemCard(_resultList[index]));
      default:
        return new Container();
    }
  }

  AppBar _buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Search Movies'),
        actions: [searchBar.getSearchAction(context)]);
  }
}

enum LoadingState { DONE, LOADING, WAITING, ERROR }
