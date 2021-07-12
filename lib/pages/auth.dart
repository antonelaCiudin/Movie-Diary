import 'package:flutter/material.dart';
import 'package:movie_diary/services/auth.dart';
import 'package:movie_diary/user.dart';
import 'package:toast/toast.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthorizationPage extends StatefulWidget {
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email;
  String password;
  bool showLogin = true;

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Widget button(String text, void func()) {

      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
        ),
          onPressed: func,
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff8AAE60),
                fontSize: 20)
          ),
      );

    }
    Widget input(Icon icon, String field,
        TextEditingController textEditingController,
        bool hidePass) {

      return Container(
        color: Color(0xff8AAE60),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          controller: textEditingController,
          obscureText: hidePass,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          decoration: InputDecoration(
              hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white30
              ),
              hintText: field,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 3)
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54, width: 1)
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                    data: IconThemeData(
                        color: Colors.white
                    ),
                    child: icon
                ),
              )
          ),
        ),
      );

    }

    void loginButton() async{
      email = emailController.text;
      password = passwordController.text;

      if(email.isEmpty || password.isEmpty) return;

      MyUser myUser = await authService.signInWithEmailAndPassword(email, password);

      if(myUser == null){
        Toast.show("Wrong Email/Password.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);

      } else {
        passwordController.clear();
        emailController.clear();
      }
    }

    void registerButton() async{
      email = emailController.text;
      password = passwordController.text;

      if(email.isEmpty || password.isEmpty) {
        return;
      }

      MyUser myUser = await authService.registerWithEmailAndPassword(email, password);
      if(myUser == null){
        Toast.show("Invalid Data.", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);
      } else {
        passwordController.clear();
        emailController.clear();
      }
    }

    Widget logo() {
      return Padding(
        padding: EdgeInsets.only(top:100),
        child: Container(
          color: Color(0xff8AAE60),
          child: Align(
            child: Text(
              'Movie Diary',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    Widget form(String label, void func()) {
      return Container(
        color: Color(0xff8AAE60),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: input(Icon(Icons.email),'Email',emailController,false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child: input(Icon(Icons.lock),'Password',passwordController,true),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: button(label, func),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xff8AAE60),
      body: Column(
        children: <Widget>[
          logo(),
          (
              showLogin ?
              Column(
                children: <Widget>[
                  form('Login',loginButton),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                      child: Text(
                          'Not registered yet? Register',
                            style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                      onTap: () {
                        setState(() {
                          emailController.clear();
                          passwordController.clear();
                          showLogin = false;
                        });
                        },
                    ),
                  )
                ],
            )
          :
          Column(
            children: <Widget>[
              form('Register',registerButton),
              Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  child: Text(
                    'Already registered? Login',
                    style: TextStyle(fontSize: 20,color: Colors.white, backgroundColor: Color(0xff8AAE60)),
                  ),
                  onTap: () {
                    setState(() {
                      emailController.clear();
                      passwordController.clear();
                      showLogin = true;
                    });
                  },
                ),
              )
            ],
          )
          ),
        ],
      )
    );
  }
}
