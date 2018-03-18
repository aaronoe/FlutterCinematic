import 'package:flutter/material.dart';
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
      body: new PageView(
        children: <Widget>[
          new MovieList(title: 'Popular', category: 'popular'),
          new MovieList(title: 'Upcoming', category: 'upcoming'),
          new MovieList(title: 'Top Rated', category: 'top_rated'),
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
