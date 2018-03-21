import 'package:flutter/material.dart';
import 'package:movies_flutter/model/tvseason.dart';
import 'package:movies_flutter/util/styles.dart';
import 'package:movies_flutter/widgets/utilviews/bottom_gradient.dart';


class SeasonCard extends StatelessWidget {

  final double height;
  final double width;
  final TvSeason season;

  SeasonCard(this.season, {this.height: 140.0, this.width: 100.0});

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
        height: height,
        width: width,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Hero(
              tag: 'Season-Hero-${season.id}',
              child: new FadeInImage.assetNetwork(
                placeholder: 'assets/placeholder.jpg',
                image: season.getPosterPath(),
                fit: BoxFit.cover,
                height: height,
                width: width,
              ),
            ),
            new BottomGradient.noOffset(),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(season.getFormattedTitle(), style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 10.0),),
                  new Container(height: 4.0,),
                  new Row(
                    children: <Widget>[
                      new Expanded(child: new Icon(
                        Icons.confirmation_number, color: salmon, size: 10.0,)),
                      new Container(width: 4.0,),
                      new Expanded(
                        flex: 8,
                        child: new Text('${season.episodeCount} Episodes', softWrap: true,
                            overflow: TextOverflow.ellipsis, maxLines: 2,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 8.0)
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}