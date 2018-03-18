import 'package:flutter/material.dart';
import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/widgets/movie_detail/cast_card.dart';

class CastSection extends StatelessWidget {

  final List<Actor> _cast;

  CastSection(this._cast);

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text("Cast", style: new TextStyle(color: Colors.white),),
        new Container(height: 8.0,),
        new Container(
          height: 140.0,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: _cast.map((Actor actor) =>
            new Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: new CastCard(actor),
            )
            ).toList(),
          ),
        )
      ],
    );
  }

}
