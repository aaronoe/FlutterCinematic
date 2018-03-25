import 'package:flutter/material.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/model/tvseason.dart';
import 'package:movies_flutter/widgets/movie_detail/season-card.dart';

class SeasonSection extends StatelessWidget {

  final MediaItem _show;
  final List<TvSeason> _seasons;

  SeasonSection(this._show, this._seasons);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text("Seasons", style: new TextStyle(color: Colors.white),),
        new Container(height: 8.0,),
        new Container(
          height: 140.0,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: _seasons.map((TvSeason season) =>
            new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: new SeasonCard(_show, season),
            )
            ).toList(),
          ),
        )
      ],
    );
  }

}