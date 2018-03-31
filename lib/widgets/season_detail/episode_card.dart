import 'package:flutter/material.dart';
import 'package:movies_flutter/model/episode.dart';
import 'package:movies_flutter/util/styles.dart';
import 'package:movies_flutter/util/utils.dart';


class EpisodeCard extends StatelessWidget {

  final Episode episode;

  EpisodeCard(this.episode);

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new InkWell(
        onTap: () => null,
        child: new Column(
          children: <Widget>[
            new FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                height: 220.0,
                width: double.infinity,
                placeholder: "assets/placeholder.jpg",
                image: episode.stillUrl
            ),
            new ListTile(
              title: new Text(episode.title),
              subtitle: new Text(formatDate(episode.airDate)),
              leading: new CircleAvatar(child: new Text(episode.episodeNumber.toString())),
            ),
            new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: new Text(episode.overview, style: captionStyle),
            )
          ],
        ),
      ),
    );
  }
}
