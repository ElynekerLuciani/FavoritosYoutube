import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataSearch extends SearchDelegate<String> {

  //botoes no topo quando estiver pesquisando
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = "";

          },
      )
    ];
  }

  //botao no canto superior esquerdo para voltar (pode colocar outros)
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation ,
        ),
        onPressed: (){
          close(context, null);
        },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));
    return Container(

    );
  }

  //carrega toda vez que digita na pesquisa
  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return Container(

      );
    } else {
      return FutureBuilder<List>(
        future: suggestions(query),
        // ignore: missing_return
        builder: (context, snapshot){
          if(! snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                // ignore: missing_return
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data[index]),
                    leading: Icon(Icons.play_arrow),
                    onTap: (){
                      close(context, snapshot.data[index]);

                    },
                  );

                },
              itemCount: snapshot.data.length,
            );
          }
        },
      );
    }

  }

  Future<List> suggestions(String search) async {
    http.Response response = await http.get(
        "http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"
    );

    if(response.statusCode == 200) {
      return json.decode(response.body)[1].map((doc){
        return doc[0];

      }).toList();

    } else {
      throw Exception("Falha ao carregar sugestões");
    }
  }
  

}