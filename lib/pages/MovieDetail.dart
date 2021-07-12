// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_diary/models/ListOfMovies.dart';
import 'package:movie_diary/models/Movie.dart';
import 'package:movie_diary/models/MovieInfo.dart';
import 'package:movie_diary/services/database.dart';
import 'package:movie_diary/services/movieService.dart';
import 'package:movie_diary/components/PaddedText.dart';
import 'package:movie_diary/user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:animated_button/animated_button.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieDetail extends StatelessWidget {
  final String movieName;
  final String imdbId;
  bool movieExists = false;

  MovieDetail({this.movieName, this.imdbId});

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseService databaseService = DatabaseService();
  MyUser user;
  Movie ourMovie;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<MyUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(this.movieName,
            style: GoogleFonts.quicksand(textStyle: TextStyle(
                fontSize: 20,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w500,
                color: Colors.white))),
        backgroundColor: Color(0xff8AAE60),
      ),
      body: FutureBuilder<MovieInfo>(
          future: getMovie(this.imdbId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            alignment: Alignment.center,
                            child: Image.network(
                              snapshot.data.poster,
                              width: 200,
                            ),
                          ),
                          // Text(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Text(snapshot.data.plot, textAlign: TextAlign.justify,
                              style: GoogleFonts.quicksand(textStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff345217))),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Text("Year : " + snapshot.data.year,
                              style: GoogleFonts.quicksand(textStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff345217))),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Text("Genre : " + snapshot.data.genre,
                              style: GoogleFonts.quicksand(textStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff345217))),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Text("Directed by : " + snapshot.data.director,
                              style: GoogleFonts.quicksand(textStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff345217))),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Text("Runtime : " + snapshot.data.runtime,
                              style: GoogleFonts.quicksand(textStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff345217))),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Text("Rated : " + snapshot.data.rating,
                              style: GoogleFonts.quicksand(textStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff345217))),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Text("IMDB Rating : " + snapshot.data.imdbRating,
                              style: GoogleFonts.quicksand(textStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff345217))),),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: Text("Meta Score : " + snapshot.data.metaScore,
                              style: GoogleFonts.quicksand(textStyle: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff345217))),),
                          ),
                          SizedBox(
                            child: IconButton(
                              icon: Icon(Icons.add),
                              highlightColor: Color(0xff345217),
                              onPressed : (){
                                ourMovie = Movie(title: snapshot.data.title,
                                    year: snapshot.data.year,
                                    type: snapshot.data.genre,
                                    poster: snapshot.data.poster,
                                    imdbID: this.imdbId,
                                    runtime: snapshot.data.runtime,
                                    genre: snapshot.data.genre);
                                showAnimatedDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context){
                                      return AlertDialog(
                                        backgroundColor: Color(0xff8AAE60),
                                        title: Padding(
                                          padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                                          child: Center(child: Text('Select a list',
                                              style:GoogleFonts.quicksand(textStyle: TextStyle(
                                                  fontSize: 25,
                                                  letterSpacing: 1.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white)))),
                                        ),
                                        content: Container(
                                          width: double.minPositive,
                                          child: StreamBuilder(
                                            stream: FirebaseFirestore.instance.collection("list").where('userId',isEqualTo: user.id).snapshots(),
                                            builder: (context, snapshot) {
                                              if(!snapshot.hasData)
                                                return Center();
                                              return Expanded(
                                                child: ListView.separated(
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data.docs.length,
                                                  itemBuilder: (context, index) {
                                                    DocumentSnapshot list = snapshot.data.docs[index];
                                                    return AnimatedButton(
                                                      color: Colors.white,
                                                      width: 230,
                                                      child: Container(
                                                        height: 50,
                                                        child: Center(
                                                            child: Text(list['title'],
                                                            style: TextStyle(color: Color(0xff345217), fontSize: 20))),
                                                      ),
                                                      onPressed: () {
                                                        ListOfMovies movies = ListOfMovies(
                                                            uid: list.id,
                                                            title: list['title'],
                                                            userId: list['userId'],
                                                            listMovies: null
                                                        );
                                                        List<dynamic> listM = list['Movies'];
                                                        movies.listMovies = listM.map((e) => new Movie.fromJson(e)).toList();
                                                        for (Movie movie in movies.listMovies)
                                                          if (movie.imdbID == ourMovie.imdbID) {
                                                            movieExists = true;
                                                            break;
                                                          }
                                                        if (!movieExists) {
                                                          movies.listMovies.add(ourMovie);
                                                          databaseService.addList(movies);
                                                        }
                                                      },
                                                    );
                                                  },
                                                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  animationType: DialogTransitionType.scale,
                                  curve: Curves.fastOutSlowIn,
                                  duration: Duration(seconds: 1),
                                );
                              }
                            ),
                          )
                        ]),
                  )
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}