import 'package:flutter/material.dart';
import 'package:movies_flutter/model/searchresult.dart';
import 'package:movies_flutter/util/styles.dart';


class SearchItemCard extends StatelessWidget {

  final SearchResult item;

  SearchItemCard(this.item);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Row(
        children: <Widget>[
          new FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              height: 80.0,
              placeholder: "assets/placeholder.jpg",
              image: item.imageUrl
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                decoration: new BoxDecoration(color: primaryDark,
                    borderRadius: new BorderRadius.all(
                        new Radius.circular(4.0)
                    )
                ),
                child: new Text(item.mediaType.toUpperCase(),
                    style: new TextStyle(color: colorAccent)
                ),
              ),
              new Text(item.title),
              new Text(item.subtitle)
            ],
          )
        ],
      ),
    );
  }

}
