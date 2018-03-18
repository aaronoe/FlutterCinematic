import 'package:flutter/material.dart';
import 'package:movies_flutter/model/movie.dart';
import 'package:movies_flutter/widgets/movie_detail/movie_detail.dart';


goToMovieDetails(BuildContext context, Movie movie) {
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
}