import 'package:movie_diary/models/MovieInfo.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'Movie.dart';

class ListOfMovies {
  String uid;
  String title;
  String userId;
  List<Movie> listMovies = new List();

  ListOfMovies({this.uid, this.title,this.userId, this.listMovies});

  List<Map<String, dynamic>> _MoviesList(List<Movie> movies) {
    if (movies == null)
      return null;
    List<Map<String, dynamic>> moviesMap = List();
    movies.forEach((element) {
      moviesMap.add(element.toMap());
    });
    return moviesMap;
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'userId': userId,
      'Movies': _MoviesList(this.listMovies),
    };
  }

  static List<Movie> moviesList_fromJson(List<dynamic> movies) {
    if (movies == null)
      return null;
    return movies.map((e) => Movie.fromJson(e)).toList();
  }

  factory ListOfMovies.fromJson(String uid, Map<String, dynamic> json) {
    return ListOfMovies(
      uid: uid,
      title: json['Title'],
      userId: json['userId'],
      listMovies: moviesList_fromJson(json['Movies']),
    );
  }
}