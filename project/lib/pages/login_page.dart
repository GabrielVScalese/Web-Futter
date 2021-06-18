import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(right: 320),
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  'Hello.',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(right: 130),
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  'Welcome back.',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                width: 400,
                child: TextField(
                  style: GoogleFonts.inter(fontSize: 12),
                  decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(fontSize: 15),
                      suffixIcon: Icon(
                        Icons.person,
                        size: 20,
                      )),
                ),
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 50),
                width: 400,
                child: TextField(
                  style: GoogleFonts.inter(fontSize: 12),
                  obscureText: isObscure,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: 15),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                          size: 20,
                        ),
                      )),
                ),
              ),
            ),
            Center(
              child: Container(
                child: Text(
                  'Forgot Password?',
                  style: GoogleFonts.inter(
                      fontSize: 11, color: Color.fromRGBO(128, 128, 128, 1)),
                ),
                padding: EdgeInsets.only(top: 20, left: 310),
              ),
            ),
            Center(
              child: Container(
                width: 400,
                height: 40,
                margin: EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text(
                    'LOGIN',
                    style: GoogleFonts.inter(fontSize: 13),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                child: Text(
                  'Create account',
                  style: GoogleFonts.inter(
                      fontSize: 15, color: Color.fromRGBO(128, 128, 128, 1)),
                ),
                padding: EdgeInsets.only(top: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
