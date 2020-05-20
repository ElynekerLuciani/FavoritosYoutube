import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosyoutube/blocs/videos_bloc.dart';
import 'package:favoritosyoutube/screens/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: MaterialApp(
        title: 'FavyTube',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),

    );
  }
}
