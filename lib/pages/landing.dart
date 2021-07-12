import 'package:flutter/material.dart';
import 'package:movie_diary/main.dart';
import 'package:movie_diary/pages/auth.dart';
import 'package:movie_diary/user.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';

class LandingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final MyUser myUser = Provider.of<MyUser>(context);
    final bool isLoggedIn = myUser != null;

    return isLoggedIn ? HomePage() : AuthorizationPage();
  }
}
