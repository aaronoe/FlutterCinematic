import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movies_flutter/model/cast.dart';
import 'package:movies_flutter/model/mediaitem.dart';
import 'package:movies_flutter/util/api_client.dart';
import 'package:movies_flutter/util/styles.dart';
import 'package:movies_flutter/widgets/movie_list/movie_list_item.dart';
import 'package:movies_flutter/widgets/utilviews/fitted_circle_avatar.dart';


class ActorDetailScreen extends StatelessWidget {
  final Actor _actor;
  final ApiClient _apiClient = ApiClient.get();

  ActorDetailScreen(this._actor);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        backgroundColor: primary,
        body: new NestedScrollView(
          body: new TabBarView(
            children: <Widget>[
              _buildMoviesSection(_apiClient.getMoviesForActor(_actor.id)),
              _buildMoviesSection(_apiClient.getShowsForActor(_actor.id)),
            ],
          ),
          headerSliverBuilder: (BuildContext context,
              bool innerBoxIsScrolled) => [_buildAppBar(context, _actor)],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, Actor actor) {
    return new SliverAppBar(
      expandedHeight: 240.0,
      bottom: new TabBar(
        tabs: <Widget>[
          new Tab(icon: new Icon(Icons.movie),),
          new Tab(icon: new Icon(Icons.tv),),
        ],
      ),
      pinned: true,
      flexibleSpace: new FlexibleSpaceBar(
        background: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [
                    const Color(0xff2b5876),
                    const Color(0xff4e4376),
                  ]
              )
          ),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(height: MediaQuery
                  .of(context)
                  .padding
                  .top,),
              new Hero(
                  tag: 'Cast-Hero-${actor.id}',
                  child: new Container(
                    width: 112.0,
                    height: 112.0,
                    child: new FittedCircleAvatar(
                      backgroundImage: new NetworkImage(
                          actor.getProfilePicture()
                      ),
                    ),
                  )
              ),
              new Container(height: 8.0,),
              new Text(actor.name, style: whiteBody.copyWith(fontSize: 22.0),),
              new Container(height: 16.0,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoviesSection(Future<List<MediaItem>> future) {
    return new FutureBuilder(
      future: future,
      builder: (BuildContext context,
          AsyncSnapshot<List<MediaItem>> snapshot) {
        return snapshot.hasData
            ? new ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
          new MovieListItem(snapshot.data[index]),
          itemCount: snapshot.data.length,
        )
            : new Padding(
          padding: const EdgeInsets.all(32.0),
          child: new Center(child: new CircularProgressIndicator()
          ),
        );
      },
    );
  }

}