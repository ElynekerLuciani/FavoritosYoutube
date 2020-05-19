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
            onPressed: (){},
          )
        ],
      ),
      body: Container(

      ),
    );
  }
}
