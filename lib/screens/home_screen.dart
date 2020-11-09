import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertravelman/models/user_data.dart';
import 'package:fluttertravelman/screens/feed.dart';
import 'package:fluttertravelman/screens/profile_screen.dart';
import 'package:fluttertravelman/screens/chat_screen.dart';
import 'package:fluttertravelman/screens/third_screen.dart';
import 'package:fluttertravelman/screens/upload_post_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

/*
Made by 'pure coincidence', and sponsored by 'i keep googling things, and somehow it works'
*/

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController = PageController(initialPage: 0);
  int _currentTab = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onTap(int index) {
    setState(() {
      _currentTab = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 400), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() => _currentTab = index);
        },
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Container(
              child: FeedScreen(
                  userId: Provider.of<UserData>(context).currentUserId)),
          Container(child: ChatScreen()),
          Container(
              child: Uploader(
                  userId: Provider.of<UserData>(context).currentUserId)),
          Container(child: ToursScreen()),
          Container(
            child: ProfileScreen(
              userId: Provider.of<UserData>(context).currentUserId,
            ),
          ), // in case of emergency break Class
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentTab,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.home,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.mapMarkerAlt,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.plusSquare,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.envelopeOpenText,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              FontAwesomeIcons.user,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
