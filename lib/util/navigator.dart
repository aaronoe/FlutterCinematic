import 'package:flutter/material.dart';
import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/movie.dart';
import 'package:movies_flutter/widgets/actor_detail/actor_detail.dart';
import 'package:movies_flutter/widgets/movie_detail/movie_detail.dart';


goToMovieDetails(BuildContext context, Movie movie) {
  _pushWidgetWithFade(context, new MovieDetailWidget(movie));
}

goToActorDetails(BuildContext context, Actor actor) {
  _pushWidgetWithFade(context, new ActorDetailScreen(actor));
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