import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MovieListState();
  }
}

Future<Map> getJson() async {
  var url =
      'https://api.themoviedb.org/3/discover/movie?api_key=1edce486c19c0cf8ddc187c00d6259a0'; // This is a deprecated API as the website has been shut down
  var response = await http.get(Uri.parse(url));
  return json.decode(response.body);
}

class _MovieListState extends State<MovieList> {
  var image_url = 'https://image.tmdb.org/t/p/w500/';
  var movies;
  Color mainColor = const Color(0xff3C3261);

  void getData() async {
    var data = await getJson();
    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      backgroundColor: Color(0xff8aae60),
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0.4,
        backgroundColor: Color(0xff8aae60) ,
        title: new Text(
          'Top Rated Films',
            style: GoogleFonts.quicksand(textStyle: TextStyle(
                fontSize: 20,
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff345217)))
        ),
      ),
      body: new Padding(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(
                child:GridView.builder(
                    itemCount: movies == null ? 0 : movies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return  Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.network(
                                  image_url+movies[index]['poster_path'],
                              ),
                            ),
                            Center(
                            child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Text(movies[index]['title'],
                                style: GoogleFonts.quicksand(textStyle: TextStyle(
                                    fontSize: 10,
                                    letterSpacing: 1.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff345217)))),
                            )),
                          ],
                        )
                      );

                    }
                )
            )
          ],
        ),
      ),
    );
  }
}
