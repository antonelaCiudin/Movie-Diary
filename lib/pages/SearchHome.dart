import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_diary/models/Movie.dart';
import 'package:movie_diary/services/movieService.dart';
import 'package:movie_diary/components/MovieList.dart';
import 'MovieDetail.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchHome extends StatefulWidget {
  @override
  _SearchHomeState createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {

  final searchTextController = new TextEditingController();
  String searchText = "";

  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  void itemClick(Movie movie) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder:
                (context) => MovieDetail(
                  movieName: movie.title,
                  imdbId: movie.imdbID,
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SEARCH A MOVIE',
            style: GoogleFonts.quicksand(textStyle: TextStyle(
                fontSize: 20,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w500,
                color: Colors.white))),
        centerTitle: true,
        backgroundColor: Color(0xff8AAE60),
      ),
      body: Column(
        children: [
          Container(
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    cursorColor: Color(0xff345217),
                    controller: searchTextController,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff8AAE60))),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff222b17)),),
                        hintText: 'Enter a name of movie',
                        hintStyle: GoogleFonts.quicksand(textStyle: TextStyle(
                          fontSize: 15,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff345217)))),
                    onSubmitted: (value){
                      setState(() {
                        searchText = searchTextController.text;
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        });
                    },
                  ),
              ),
              IconButton(
                  icon: Icon(Icons.search, color: Color(0xff345217),),
                  tooltip: 'Search Movie',
                  onPressed: () {
                    setState(() {
                      searchText = searchTextController.text;
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                    });
                  },
              ),
            ],),
            padding: EdgeInsets.all(10),
          ),
          if(searchText.length > 0)
            FutureBuilder<List <Movie>>(
              future: searchMovies(searchText),
              builder: (context, snapshot){
                if(snapshot.hasData) {
                  return Expanded(
                      child: MovieList(movies: snapshot.data, itemClick: this.itemClick)
                  );
                } else if(snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(
                  heightFactor: 10.0,
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff8AAE60)),
                ),
                );
            }),
        ],
      ),
    );
  }
}

