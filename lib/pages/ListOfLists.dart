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

import 'ListPage.dart';

class ListOfLists extends StatefulWidget {
  final MovieInfo movieSchedule;

  ListOfLists({Key key, this.movieSchedule}) : super(key: key);

  @override
  _ListOfListsState createState() => _ListOfListsState();
}

class _ListOfListsState extends State<ListOfLists> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  MyUser user ;
  MovieInfo movie = MovieInfo();
  DatabaseService databaseService = DatabaseService();

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
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed:() {
                   showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Add a new list', style: TextStyle(color: Color(0xff345217)),),
                            content: TextField(
                              onSubmitted: (value){
                                setState(() {
                                  ListOfMovies newList = ListOfMovies(userId: user.id,title: value,listMovies: new List());
                                  databaseService.addList(newList);
                                });
                              },
                              // controller: _textFieldController,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff8AAE60))),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Color(0xff222b17)),),
                                  hintText: "List name",
                                  hintStyle: TextStyle(color: Color(0xff345217))),
                            ),
                          );
                        });

                  setState(() {
                    pressed = true;
                  });
                })
          ],
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("list").where('userId',isEqualTo: user.id).snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData)
              return Center();
            return ListView.separated(
              padding: const  EdgeInsets.all(16.0),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot list = snapshot.data.docs[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Color(0xff345217),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      snapshot.data.docs.removeAt(index);
                      databaseService.deleteList(list.id);
                    });
                  },
                  direction: DismissDirection.endToStart,
                  child: AnimatedButton(
                    color:  Color(0xff8AAE60),
                    shape: BoxShape.rectangle,
                    width: 360,
                    child: Container(
                      height: 50,
                      child: Center(child: Text(list['title'],
                          style: GoogleFonts.quicksand(textStyle: TextStyle(
                              fontSize: 20,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)))),
                    ),
                    onPressed: () {
                      ListOfMovies movies = ListOfMovies(
                          title: list['title'],
                          uid: list.id,
                          userId: list['userId'],
                          listMovies: ListOfMovies.moviesList_fromJson(list['Movies'])
                      );
                      Navigator.push(
                          context,MaterialPageRoute(
                          builder: (context) => ListPage(listOfMovies: movies)
                      )
                      );
                    },
                  ),
                );
                },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
            },
        ),
    );
  }
}
