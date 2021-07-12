import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_diary/models/ListOfMovies.dart';

class DatabaseService {
  final CollectionReference lists = FirebaseFirestore.instance.collection('list');

  Future<void> addList(ListOfMovies listOfMovies) async {
    return lists.doc(listOfMovies.uid).set(listOfMovies.toJson()).then((value) => print("List added"))
    .catchError((error) => print("EROARE $error"));
  }

  Future<void> deleteList(String uid) async {
    return lists.doc(uid).delete();
  }
}