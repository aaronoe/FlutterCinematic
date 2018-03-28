import 'package:flutter/material.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/util/mediaproviders.dart';
import 'package:movies_flutter/util/navigator.dart';
import 'package:movies_flutter/widgets/movie_list/movie_list.dart';


class HomePage extends StatefulWidget {

  @override
  State createState() => new HomePageState();

}

class HomePageState extends State<HomePage> {

  PageController _pageController;
  int _page = 0;
  MediaType mediaType = MediaType.movie;

  final MediaProvider movieProvider = new MovieProvider();
  final MediaProvider showProvider = new ShowProvider();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search, color: Colors.white),
            onPressed: () => goToSearch(context),
          )
        ],
        title: new Text("Cinematic"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
                padding: const EdgeInsets.all(0.0),
                child: new Container(
                  decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            const Color(0xff2b5876),
                            const Color(0xff4e4376),
                          ]
                      )
                  ),
                )),
            new ListTile(
              title: new Text("Search"),
              trailing: new Icon(Icons.search),
              onTap: () => goToSearch(context),
            ),
            new Divider(height: 5.0,),
            new ListTile(
              title: new Text("Movies"),
              selected: mediaType == MediaType.movie,
              trailing: new Icon(Icons.local_movies),
              onTap: () {
                _changeMediaType(MediaType.movie);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("TV Shows"),
              selected: mediaType == MediaType.show,
              trailing: new Icon(Icons.live_tv),
              onTap: () {
                _changeMediaType(MediaType.show);
                Navigator.of(context).pop();
              },
            ),
            new Divider(height: 5.0,),
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
      body: new PageView(
        children: _getMediaList(),
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: _getNavBarItems(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<BottomNavigationBarItem> _getNavBarItems() {
    if (mediaType == MediaType.movie) {
      return [
        new BottomNavigationBarItem(
            icon: new Icon(Icons.thumb_up), title: new Text('Popular')),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.update), title: new Text('Upcoming')),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.star), title: new Text('Top Rated')),
      ];
    } else {
      return [
        new BottomNavigationBarItem(
            icon: new Icon(Icons.thumb_up), title: new Text('Popular')),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.live_tv), title: new Text('On The Air')),
        new BottomNavigationBarItem(
            icon: new Icon(Icons.star), title: new Text('Top Rated')),
      ];
    }
  }

  List<Widget> _getMediaList() {
    return (mediaType == MediaType.movie)
        ? <Widget>[
      new MediaList(movieProvider, "popular", key: new Key("movies-popular"),),
      new MediaList(movieProvider, "upcoming", key: new Key("movies-upcoming")),
      new MediaList(movieProvider, "top_rated", key: new Key("movies-top_rated")),
    ]
        : <Widget>[
      new MediaList(showProvider, "popular", key: new Key("shows-popular")),
      new MediaList(showProvider, "on_the_air", key: new Key("movies-on_the_air")),
      new MediaList(showProvider, "top_rated", key: new Key("movies-top_rated")),
    ];
  }

  void _navigationTapped(int page) {
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }


  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

}
