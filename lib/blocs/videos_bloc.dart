import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosyoutube/api/api.dart';
import 'package:favoritosyoutube/models/video.dart';

class VideosBloc implements BlocBase {
  Api api;
  List<Video> videos;

  //acesso a saida do bloc
  final StreamController<List<Video>> _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  //acesso a entrada fora do bloc
  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if(search != null) {
      _videosController.sink.add([]);
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);

  }


  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();

  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
  
}