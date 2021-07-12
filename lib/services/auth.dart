import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_diary/user.dart';
import 'package:movie_diary/models/ListOfMovies.dart';

import 'database.dart';
class AuthService{
  final FirebaseAuth fAuth = FirebaseAuth.instance;

  Future<MyUser> signInWithEmailAndPassword(String email, String password) async{

    try {
      UserCredential userCredential = await fAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return MyUser.fromFirebase(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  Future<MyUser> registerWithEmailAndPassword(String email, String password) async{

    try {
      UserCredential userCredential = await fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      List<ListOfMovies> lists = [new ListOfMovies(title: 'Watched',userId: user.uid, listMovies: new List()),
        new ListOfMovies(title: 'To watch', userId: user.uid, listMovies: new List()),
        new ListOfMovies(title: 'Liked', userId: user.uid, listMovies: new List())];
      DatabaseService databaseService = DatabaseService();
      lists.forEach((element) {databaseService.addList(element);});
      return MyUser.fromFirebase(user);
    } catch(e) {
      print(e);
      return null;
    }
  }

  Future logOut() async{
    await fAuth.signOut();
  }

  Stream<MyUser> get currentUser {
    return fAuth.authStateChanges().map((User user) => user != null ? MyUser.fromFirebase(user):null);
  }
}