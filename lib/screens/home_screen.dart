import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosyoutube/blocs/videos_bloc.dart';
import 'package:favoritosyoutube/delegates/data_search.dart';
import 'package:favoritosyoutube/widgets/video_tile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: Text(
              "0",
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.star),
              color: Colors.grey,
              onPressed: (){},
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
        stream: BlocProvider.of<VideosBloc>(context).outVideos,
        // ignore: missing_return
        builder: (context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                // ignore: missing_return
                itemBuilder: (context, index) {
                  return VideoTile(snapshot.data[index]);

                },
              itemCount: snapshot.data.length,
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
