import 'package:flutter/material.dart';
import 'package:movie_diary/pages/ListOfLists.dart';
import 'package:movie_diary/pages/Statistics.dart';
import 'package:movie_diary/services/auth.dart';
import 'package:movie_diary/top_rated_movies/movie_list.dart';
import 'SearchHome.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff8AAE60),
              ),
              child: Center(
              child: Text("W E L C O M E",
                    style: GoogleFonts.quicksand(
                    textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 2.0,
                          color: Colors.white)
                    ),
                    textAlign: TextAlign.center,),
              )
            ),
            ListTile(
              leading: Icon(Icons.search_sharp, color: Color(0xff8AAE60),),
              title: Text("Search a movie",
                  style: GoogleFonts.quicksand(textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff345217)))),
              onTap: (){
                Navigator.push(
                    context,MaterialPageRoute(builder: (context) => SearchHome()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list, color: Color(0xff8AAE60)),
              title: Text("List my lists",
                  style: GoogleFonts.quicksand(textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff345217)))),
              onTap: (){
              Navigator
                  .push(context,MaterialPageRoute(builder: (context) => ListOfLists()));
              },
            ),
            ListTile(
                leading: Icon(Icons.bar_chart_sharp, color: Color(0xff8AAE60),),
                title: Text("Statistics",
                    style: GoogleFonts.quicksand(textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff345217)))),
              onTap: (){
                Navigator
                    .push(context,MaterialPageRoute(builder: (context) => Statistics()));
              },

            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('HOME',
            style: GoogleFonts.quicksand(textStyle: TextStyle(
                fontSize: 20,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w500,
                color: Colors.white))),
        centerTitle: true,
        backgroundColor: Color(0xff8AAE60),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AuthService().logOut();
            },
            color: Colors.white,
          ),

        ],
      ),
      body: MovieList()
    );
  }
}