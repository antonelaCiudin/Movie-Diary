import 'package:flutter/material.dart';
import 'package:movie_diary/components/MovieItemFromList.dart';
import 'package:movie_diary/models/ListOfMovies.dart';
import 'package:movie_diary/services/database.dart';
import 'MovieItem.dart';
import 'package:movie_diary/models/Movie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OurMovieList extends StatefulWidget {
  final ListOfMovies listOfMovies;
  final Function itemClick;
  const OurMovieList({Key key, this.listOfMovies, this.itemClick}) : super(key: key);

  @override
  _OurMovieListState createState() => _OurMovieListState();
}

class _OurMovieListState extends State<OurMovieList> {
  @override
  Widget build(context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: widget.listOfMovies.listMovies.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(widget.listOfMovies.listMovies[index].imdbID),
                background: Container(
                  alignment: AlignmentDirectional.centerEnd,
                  color: Color(0xff8AAE60),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    print(widget.listOfMovies.uid);
                    widget.listOfMovies.listMovies.removeAt(index);
                    FirebaseFirestore firestore = FirebaseFirestore.instance;
                    DatabaseService databaseService = DatabaseService();

                    databaseService.addList(widget.listOfMovies);
                  });
                },
                direction: DismissDirection.endToStart,
                child: new GestureDetector(
                    child: MovieItemFromList(movie: widget.listOfMovies.listMovies[index]),
                    onTap: () => widget.itemClick(widget.listOfMovies.listMovies[index])),
              );
            }
            )
    );
  }
}
