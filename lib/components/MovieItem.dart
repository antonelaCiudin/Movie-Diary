import 'package:flutter/material.dart';
import 'package:movie_diary/models/Movie.dart' as models;

class MovieItem extends StatelessWidget {
  final models.Movie movie;

  MovieItem({this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible( child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                if (this.movie.poster != "N/A")
                  Image.network(this.movie.poster,height: 330, width: 340, fit: BoxFit.contain),
               Text(
                  this.movie.title,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(0xff345217), fontStyle: FontStyle.italic, fontWeight: FontWeight.w700, letterSpacing: 4),
                ),
                Text(this.movie.year,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(0xff345217), fontStyle: FontStyle.italic, fontWeight: FontWeight.w700, letterSpacing: 4),
                ),
                // Text(this.movie.type)

              ]),)
        ],
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 8, left: 10, right: 10),
      // decoration:
      // new BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)),color: Colors.white),
    );
  }
}