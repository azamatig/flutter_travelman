import 'package:flutter/material.dart';
import 'package:fluttertravelman/services/auth_service.dart';
import 'package:fluttertravelman/utils/const.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EnterAppScreen extends StatefulWidget {
  static final String id = 'enter_app_screen';

  @override
  _EnterAppScreenState createState() => _EnterAppScreenState();
}

class _EnterAppScreenState extends State<EnterAppScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? GFLoader(
              size: 50,
            )
          : Stack(children: [
              Positioned(
                  top: 57,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(FontAwesomeIcons.chevronLeft, size: 20),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'назад',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700, fontSize: 12),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                top: 150,
                left: 25,
                child: Container(
                  width: 380,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                            validator: (input) => !input.contains('@')
                                ? 'Please enter a valid email'
                                : null,
                            onSaved: (input) => _email = input,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 10.0,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Пароль',
                                labelStyle: GoogleFonts.poppins(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                            validator: (input) => input.length < 6
                                ? 'Must be at least 6 characters'
                                : null,
                            onSaved: (input) => _password = input,
                            obscureText: true,
                          ),
                        ),
                        SizedBox(height: 50.0),
                        Container(
                          width: 320.0,
                          height: 65,
                          child: GFButton(
                            elevation: 5,
                            color: pinBlue,
                            size: 50,
                            shape: GFButtonShape.pills,
                            onPressed: () {
                              _login();
                            },
                            child: Text(
                              'Войти',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
    );
  }

  _login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // Logging in the user w/ Firebase
      AuthService.login(_email, _password);
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(seconds: 2), () {});
      Navigator.pop(context);
    }
  }
}
