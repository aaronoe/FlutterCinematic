import 'package:flutter/material.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/model/tvseason.dart';
import 'package:movies_flutter/util/styles.dart';


class SeasonDetailScreen extends StatelessWidget {

  final MediaItem show;
  final TvSeason season;

  SeasonDetailScreen(this.show, this.season);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: primary,
        body: new CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(show, season),
          ],
        )
    );
  }

  Widget _buildAppBar(MediaItem show, TvSeason season) {
    return new SliverAppBar(
      expandedHeight: 300.0,
      pinned: true,
      flexibleSpace: new FlexibleSpaceBar(
        background: new Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: <Widget>[
            new Column(
              children: <Widget>[
                new FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    height: 230.0,
                    width: double.INFINITY,
                    placeholder: "assets/placeholder.jpg",
                    image: show.getBackDropUrl()),
                new Expanded(
                  child: new Container(
                    child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new Text(show.title, style: captionStyle,),
                          new Container(height: 4.0,),
                          new Text(
                              "Season ${season.seasonNumber}",
                              style: whiteBody.copyWith(fontSize: 18.0)),
                          new Container(height: 4.0,),
                          new Text(
                            "${season.getReleaseYear()} - ${season
                                .episodeCount} Episodes",
                            style: captionStyle,
                          )
                        ],
                      ),
                    ),
                    color: primaryDark,
                  ),
                )
              ],
            ),
            new Padding(
              padding: const EdgeInsets.all(24.0),
              child: new FadeInImage.assetNetwork(
                  width: 100.0,
                  placeholder: "assets/placeholder.jpg",
                  image: season.getPosterUrl()),
            ),
          ],
        ),
      ),
    );
  }

}
