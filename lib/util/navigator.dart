import 'package:flutter/material.dart';
import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/model/tvseason.dart';
import 'package:movies_flutter/util/mediaproviders.dart';
import 'package:movies_flutter/widgets/actor_detail/actor_detail.dart';
import 'package:movies_flutter/widgets/favorites/favorite_screen.dart';
import 'package:movies_flutter/widgets/movie_detail/movie_detail.dart';
import 'package:movies_flutter/widgets/search/search_page.dart';
import 'package:movies_flutter/widgets/season_detail/season_detail_screen.dart';

goToMovieDetails(BuildContext context, MediaItem movie) {
  MediaProvider provider = (movie.type == MediaType.movie)
      ? new MovieProvider()
      : new ShowProvider();
  _pushWidgetWithFade(context, new MovieDetailScreen(movie, provider));
}

goToSeasonDetails(BuildContext context, MediaItem show, TvSeason season) =>
    _pushWidgetWithFade(context, new SeasonDetailScreen(show, season));

goToActorDetails(BuildContext context, Actor actor) {
  _pushWidgetWithFade(context, new ActorDetailScreen(actor));
}

goToSearch(BuildContext context) {
  _pushWidgetWithFade(context, new SearchScreen());
}

goToFavorites(BuildContext context) {
  _pushWidgetWithFade(context, new FavoriteScreen());
}

_pushWidgetWithFade(BuildContext context, Widget widget) {
  Navigator.of(context).push(
        new PageRouteBuilder(
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    new FadeTransition(opacity: animation, child: child),
            pageBuilder: (BuildContext context, Animation animation,
                Animation secondaryAnimation) {
              return widget;
            }),
      );
}
