import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_diary/components/MovieList.dart';
import 'package:movie_diary/models/ListOfMovies.dart';
import 'package:movie_diary/models/Movie.dart';
import 'package:movie_diary/models/MovieInfo.dart';
import 'package:movie_diary/pages/MovieDetail.dart';
import 'package:movie_diary/services/database.dart';
import 'package:movie_diary/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:animated_button/animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_button/animated_button.dart';
import 'ListPage.dart';

class Statistics extends StatefulWidget {
  final MovieInfo movieSchedule;

  Statistics({Key key, this.movieSchedule}) : super(key: key);

  @override
  _Statistics createState() => _Statistics();
}

class _Statistics extends State<Statistics> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  MyUser user ;
  MovieInfo movie = MovieInfo();
  DatabaseService databaseService = DatabaseService();
  double showHours = 0.0;
  double showGenres = 0.0;
  ListOfMovies movies;
  bool listExtracted = false;
  int minutes;
  List<Movie> allMovies = List<Movie>();

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

  String computeHours(String userID) {
    String ret = "heeey";
    minutes = 0;

    for (int i = 0; i < movies.listMovies.length; i++) {
      minutes += int.parse(movies.listMovies[i].runtime.toString().substring(0,movies.listMovies[i].runtime.toString().length - 4));
    }

    var d = Duration(minutes:minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padRight(2, 'h')} ${parts[1]}min';
  }

  Widget getHours(String userID) {
    if (showHours == 0.0)
      return
        Text('Watched hours',
            style: GoogleFonts.quicksand(textStyle: TextStyle(
                fontSize: 20,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w500,
                color: Color(0xff345217))));
    else
      return  Container(
        alignment: Alignment.center,
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          // color: Color(0xff8AAE60),
          border: Border.all(color: Color(0xff345217)),
          borderRadius: BorderRadius.circular(360.0)
          // shape: BoxShape.circle
        ),
        child: Container(
          child: Text(computeHours(userID),
                style: GoogleFonts.quicksand(textStyle: TextStyle(
                    fontSize: 20,
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                    color:  Color(0xff345217)))),
        ),
      );
  }

  Widget getTopGenre() {
    Map map = Map<String, int>();
    var topGenres;

    for (Movie movie in allMovies){
      var arr = movie.genre.split(', ');
      for (String genre in arr) {
        if (!map.containsKey(genre))
          map[genre] = 1;
        else
          map[genre] = map[genre] + 1;
      }
    }

    var sortedMap = Map.fromEntries(
        map.entries.toList()
          ..sort((e1, e2) => e1.value.compareTo(e2.value)));
    topGenres = sortedMap.keys.toList().reversed;
    // print(topGenres);

    List<String> new_list = List();

    for (var a in topGenres) {
      new_list.add(a);
    }

    print(new_list);

    if (showGenres == 1)
      return
        ColoredBox(
          color: Color(0xff8AAE60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget> [
              for (int i = 0; i < 5; i++)
                if (new_list.length > i)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(new_list[i],
                      style: GoogleFonts.quicksand(textStyle: TextStyle(
                          fontSize: 15,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w500,
                          color:  Colors.white))),
                )
            ]
          ),
        );
    else
      return Center();
  }

  Widget build(BuildContext context) {
    user = Provider.of<MyUser>(context);
    bool pressed = false;
    String listName = "";
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL LISTS',
            style: GoogleFonts.quicksand(textStyle: TextStyle(
                fontSize: 20,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w500,
                color: Colors.white))),
        centerTitle: true,
        backgroundColor: Color(0xff8AAE60),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("list").where('userId',isEqualTo: user.id).snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              List<Movie> newList = List();
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                DocumentSnapshot list = snapshot.data.docs[i];
                if (ListOfMovies.moviesList_fromJson(list['Movies']) != null) {
                  for (Movie m in ListOfMovies.moviesList_fromJson(list['Movies']))
                    newList.add(m);
                }
              }
              allMovies = newList;
              for (int i = 0; i < snapshot.data.docs.length; i++) {
                DocumentSnapshot list = snapshot.data.docs[i];
                if (list['title'] == 'Watched') {
                  movies = ListOfMovies(
                      title: list['title'],
                      uid: list.id,
                      userId: list['userId'],
                      listMovies: ListOfMovies.moviesList_fromJson(list['Movies'])
                  );
                  break;
                }
              }
            }
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AnimatedButton(
                            height: 150,
                            color: Colors.transparent ,
                            child: getHours(user.id),
                            onPressed: () => setState(() {
                              if (showHours == 1)
                                showHours = 0.0;
                              else
                                showHours = 1;
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                ColoredBox(
                  color: Color(0xff8AAE60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AnimatedButton(
                                  height: 50,
                                  color: Colors.transparent ,
                                  child: Text("Top genres",
                                    style: GoogleFonts.quicksand(textStyle: TextStyle(
                                        fontSize: 20,
                                        letterSpacing: 2.0,
                                        fontWeight: FontWeight.w500,
                                        color:  Colors.white))),
                                  onPressed: () => setState(() {
                                    if (showGenres == 1)
                                      showGenres = 0.0;
                                    else
                                      showGenres = 1;
                                  }),
                                ),
                              ],
                            ),
                          ),
                          getTopGenre()
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
