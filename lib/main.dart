import 'package:favoritosyoutube/api/api.dart';
import 'package:favoritosyoutube/widgets/app.dart';
import 'package:flutter/material.dart';

//void main() => runApp(App());

void main() {
  Api api = Api();
  api.search("eletronica");
    
  runApp(App());
}

