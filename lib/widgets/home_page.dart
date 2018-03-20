import 'package:flutter/material.dart';
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
            new UserAccountsDrawerHeader(
              accountName: new Text("Aaron Oertel"),
              accountEmail: new Text("aaronoe97@gmail.com"),
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        const Color(0xff2b5876),
                        const Color(0xff4e4376),
                      ]
                  )
              ),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://lh3.googleusercontent.com/FY6e3irMirjwH-I7OWBL62XJcTgkNdXvMcDLzyyuJ3ZjtEqE31FKeFrVcwkFqwnR_FtTSdauTsBXxw=s529-rw-no'),),
            ),
            new ListTile(
              title: new Text("Popular"),
              trailing: new Icon(Icons.thumb_up),
              onTap: () {
                _navigationTapped(0);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("Upcoming"),
              trailing: new Icon(Icons.update),
              onTap: () {
                _navigationTapped(1);
                Navigator.of(context).pop();
              },
            ),
            new ListTile(
              title: new Text("Top Rated"),
              trailing: new Icon(Icons.star),
              onTap: () {
                _navigationTapped(2);
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
        children: <Widget>[
          new MovieList(new MovieProvider("popular"), title: 'Popular'),
          new MovieList(new MovieProvider("upcoming"), title: 'Upcoming'),
          new MovieList(new MovieProvider("top_rated"), title: 'Top Rated'),
        ],
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.thumb_up), title: new Text('Popular')),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.update), title: new Text('Upcoming')),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.star), title: new Text('Top Rated')),
        ],
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
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
