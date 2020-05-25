import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosyoutube/blocs/favorite_bloc.dart';
import 'package:favoritosyoutube/blocs/videos_bloc.dart';
import 'package:favoritosyoutube/delegates/data_search.dart';
import 'package:favoritosyoutube/models/video.dart';
import 'package:favoritosyoutube/widgets/favorites_screen.dart';
import 'package:favoritosyoutube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<VideosBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25.0,
          child: Image.asset("images/youtube.png"),
        ),
        elevation: 1.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder<Map<String, Video>>(
              stream: BlocProvider.of<FavoriteBloc>(context).outFav,
                // ignore: missing_return
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Text(
                        "${snapshot.data.length}",
                      style: TextStyle( color: Colors.grey),
                    );
                  } else return Container();

                }
            ),
          ),
          IconButton(
              icon: Icon(Icons.star),
              color: Colors.grey,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavoritesScreen()
                ));
              },
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.grey,
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              if(result != null) BlocProvider.of<VideosBloc>(context).inSearch.add(result);

            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: bloc.outVideos,
        initialData: [],
        // ignore: missing_return
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                // ignore: missing_return
                itemBuilder: (context, index) {
                  if(index < snapshot.data.length) {
                    return VideoTile(snapshot.data[index]);
                  } else if(index >1){
                    bloc.inSearch.add(null);
                    return Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                    );
                  } else {
                    return Container();
                  }
                },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container(

            );
          }

        },
      ),
    );
  }
}
