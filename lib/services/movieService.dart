import 'dart:convert';
import 'package:movie_diary/models/Movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_diary/models/MovieInfo.dart';

const API_KEY = "caea00ef";
const API_URL = "https://www.omdbapi.com/?apikey=";


  Future<List<Movie>> searchMovies(keyword) async {
    final response = await http.get(Uri.parse('$API_URL$API_KEY&s=$keyword'));

    if (response.statusCode == 200) {
      //Decode the response
      Map data = json.decode(response.body);

      if (data['Response'] == "True") {
        //map the json objects to Movie objects
        var list = (data['Search'] as List)
            .map((item) => new Movie.fromJson(item))
            .toList();
        return list;
      } else {
        throw Exception(data['Error']);
      }
    } else {
      throw Exception('Something went wrong !');
    }
  }

  Future<MovieInfo> getMovie(movieId) async {
    final response = await http.get(Uri.parse('$API_URL$API_KEY&i=$movieId'));

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);

      if (data['Response'] == "True") {
        return MovieInfo.fromJSON(data);
      } else {
        throw Exception(data['Error']);
      }
    } else {
      throw Exception('Something went wrong !');
    }
  }



