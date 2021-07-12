import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_diary/models/ListOfMovies.dart';

class MyUser{

  String id;

  MyUser.fromFirebase(User user){
    id = user.uid;
    // List<ListOfMovies> lists = new List();
  }
}