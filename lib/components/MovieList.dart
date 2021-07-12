import 'package:flutter/material.dart';
import 'package:movie_diary/models/Movie.dart';
import 'MovieItem.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final Function itemClick;

  MovieList({this.movies, this.itemClick});

  @override
  Widget build(context) {
    return new Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: Expanded(
          child: GridView.count(
              // padding: const EdgeInsets.all(8.0),
              crossAxisCount: 1,
              children: List.generate(this.movies.length, (index) {
                return new GestureDetector(
                    child: MovieItem(movie: this.movies[index]),
                    onTap: () => this.itemClick(this.movies[index]));
              })),
        ));
  }
}