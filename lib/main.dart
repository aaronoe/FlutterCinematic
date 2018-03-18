import 'package:async_loader/async_loader.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:movies_flutter/model/movie.dart';
import 'package:movies_flutter/util/api_client.dart';
import 'package:movies_flutter/widgets/movie_detail.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => new HomePage(),
      },
    );
  }

}


class HomePage extends StatefulWidget {

  @override
  State createState() => new HomePageState();

}

class HomePageState extends State<HomePage> {

  PageController _pageController;
  int _page = 0;

  _test() async {
    final LocalAuthentication auth = new LocalAuthentication();
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: false);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(onPressed: _test),
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

                return new MovieWidget(_movies[index]);
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

class MovieWidget extends StatelessWidget {

  MovieWidget(this.movie);

  final Movie movie;

  Widget _getTitleSection() {
    var ratingColor = Color.lerp(
        Colors.red, Colors.green, movie.voteAverage / 10.0);

    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  child: new Text(
                    movie.title,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: new Text(
                    movie.releaseDate,
                    style: new TextStyle(
                      color: Colors.grey[500],
                    ),
                  ),
                )
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.all(4.0),
            child: new Icon(
              Icons.star,
              color: ratingColor,
            ),
          ),
          new Text(movie.voteAverage.toString()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          new PageRouteBuilder(
              transitionsBuilder: (context, animation, secondaryAnimation,
                  child) =>
              new FadeTransition(opacity: animation, child: child),
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return new MovieDetailWidget(movie);
              }),
        );
      },
      child: new Card(
        child: new Column(
          children: <Widget>[
            new Hero(
              /*
              child: new CachedNetworkImage(
                imageUrl: movie.getBackDropUrl(),
                placeholder: new Image.asset(
                  "assets/placeholder.jpg",
                    height: 200.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
              ),
              */
              child: new FadeInImage.assetNetwork(
                placeholder: "assets/placeholder.jpg",
                image: movie.getBackDropUrl(),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
                fadeInDuration: new Duration(milliseconds: 50),
              ),
              tag: "Movie-Tag-${movie.id}",
            ),
            _getTitleSection(),
          ],
        ),
      ),
    );
  }

}