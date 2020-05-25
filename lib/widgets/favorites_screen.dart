import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosyoutube/blocs/favorite_bloc.dart';
import 'package:favoritosyoutube/models/video.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Favoritos",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
          initialData: {},
          // ignore: missing_return
          builder: (context, snapshot) {
          return ListView(
            children: snapshot.data.values.map((v){
              return InkWell(
                onTap: (){

                },
                onLongPress: (){
                  bloc.toggleFavorite(v);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(v.thumb),
                    ),
                    Expanded(
                        child: Text(
                          v.title,
                          style: TextStyle(
                              color: Colors.grey,
                          ),
                          maxLines: 2,
                        )
                    )
                  ],
                ),
              );
            }).toList(),
          );

          }
      ),
    );
  }
}