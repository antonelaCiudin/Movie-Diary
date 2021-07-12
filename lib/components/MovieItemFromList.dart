import 'package:flutter/material.dart';
import 'package:movie_diary/models/Movie.dart' as models;
import 'package:google_fonts/google_fonts.dart';

class MovieItemFromList extends StatelessWidget {
  final models.Movie movie;

  MovieItemFromList({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(children: <Widget>[
            if (this.movie.poster != "N/A")
              Image.network(this.movie.poster, height: 150, width: 100)
          ]),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: Text(this.movie.title,
                      style: GoogleFonts.quicksand(textStyle: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff345217))),),
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: Text(this.movie.year,
                      style: GoogleFonts.quicksand(textStyle: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff345217))),),
                  ),Padding(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                    child: Text(this.movie.type,
                      style: GoogleFonts.quicksand(textStyle: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff345217))),),
                  ),
                ]),
          ),)
        ],
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 8, left: 10, right: 10),
      decoration:
      new BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Colors.white),
    );
  }
}