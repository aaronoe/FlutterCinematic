import 'package:flutter/material.dart';
import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/movie.dart';
import 'package:movies_flutter/widgets/actor_detail/actor_detail.dart';
import 'package:movies_flutter/widgets/movie_detail/movie_detail.dart';
import 'package:movies_flutter/widgets/search/search_page.dart';


goToMovieDetails(BuildContext context, Movie movie) {
  _pushWidgetWithFade(context, new MovieDetailScreen(movie));
}

goToActorDetails(BuildContext context, Actor actor) {
  _pushWidgetWithFade(context, new ActorDetailScreen(actor));
}

goToSearch(BuildContext context) {
  _pushWidgetWithFade(context, new SearchScreen());
}

_pushWidgetWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).push(
    new PageRouteBuilder(
        transitionsBuilder: (context, animation, secondaryAnimation,
            child) =>
        new FadeTransition(opacity: animation, child: child),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return widget;
        }),
  );
}