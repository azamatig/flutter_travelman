import 'package:flutter/material.dart';
import 'package:fluttertravelman/home_screen.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color pinBlue = Color.fromARGB(255, 57, 90, 255);
    Color buttonColor = Color.fromARGB(255, 255, 213, 0);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/bck_img.png'),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 40,
            child: Text(
              'travelman.',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w900,
                  fontSize: 57,
                  color: buttonColor),
            ),
          ),
          Positioned(
            top: 300,
            left: 100,
            child: Text(
              'Travel with people. Make new friends.',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 35,
            child: Container(
              width: 350,
              child: GFButton(
                elevation: 5,
                color: Colors.white,
                size: 50,
                shape: GFButtonShape.pills,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                child: Text(
                  'Sign up',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: pinBlue),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 130,
            left: 35,
            child: Container(
              width: 350,
              child: GFButton(
                elevation: 5,
                color: pinBlue,
                size: 50,
                shape: GFButtonShape.pills,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
                child: Text(
                  'Log in',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 140,
            child: Text(
              'Forgot your password?',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
