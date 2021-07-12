import 'package:flutter/material.dart';
import 'package:movie_diary/components/MovieList.dart';
import 'package:movie_diary/components/OurMovieList.dart';
import 'package:movie_diary/models/ListOfMovies.dart';
import 'package:movie_diary/pages/SearchHome.dart';
import 'MovieDetail.dart';
import 'package:movie_diary/models/Movie.dart';
import 'package:google_fonts/google_fonts.dart';


class ListPage extends StatelessWidget {

  final ListOfMovies listOfMovies;
  const ListPage({Key key, this.listOfMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(listOfMovies.title.toUpperCase(),
              style: GoogleFonts.quicksand(textStyle: TextStyle(
                  fontSize: 20,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white))),
        centerTitle: true,
        backgroundColor: Color(0xff8AAE60),
      ),
      body: OurMovieList(listOfMovies: listOfMovies, itemClick: (Movie movie) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder:
                    (context) =>
                    MovieDetail(
                      movieName: movie.title,
                      imdbId: movie.imdbID,
                    )),
          );
      }),
      backgroundColor: Colors.white,
    );
  }
}
