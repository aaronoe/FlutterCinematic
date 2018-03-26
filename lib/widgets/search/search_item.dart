import 'package:flutter/material.dart';
import 'package:movies_flutter/model/searchresult.dart';
import 'package:movies_flutter/util/navigator.dart';
import 'package:movies_flutter/util/styles.dart';


class SearchItemCard extends StatelessWidget {

  final SearchResult item;

  SearchItemCard(this.item);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new InkWell(
        onTap: () => _handleTap(context),
        child: new Row(
          children: <Widget>[
            new FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                width: 100.0,
                height: 150.0,
                placeholder: "assets/placeholder.jpg",
                image: item.imageUrl
            ),
            new Container(width: 8.0,),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                        color: primaryDark,
                        borderRadius: new BorderRadius.all(
                            new Radius.circular(4.0)
                        )
                    ),
                    child: new Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(item.mediaType.toUpperCase(),
                          style: new TextStyle(color: colorAccent)
                      ),
                    ),
                  ),
                  new Container(height: 4.0,),
                  new Text(item.title, style: new TextStyle(fontSize: 18.0),),
                  new Container(height: 4.0,),
                  new Text(item.subtitle, style: captionStyle)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _handleTap(BuildContext context) {
    switch (item.mediaType) {
      case "movie":
        goToMovieDetails(context, item.asMovie);
        return;
      case "tv":
        goToMovieDetails(context, item.asShow);
        return;
      case "person":
        goToActorDetails(context, item.asActor);
        return;
    }
  }

}
