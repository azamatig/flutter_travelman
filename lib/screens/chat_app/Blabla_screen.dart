import 'package:flutter/material.dart';
import 'package:fluttertravelman/models/user_model.dart';
import 'package:fluttertravelman/screens/chat_app/chat_details.dart';
import 'package:fluttertravelman/services/repository.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  final String myId;

  const ChatScreen({Key key, this.myId}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _repository = Repository();
  List<UserModel> usersList = List<UserModel>();

  @override
  void initState() {
    super.initState();
    _repository.getCurrentUser().then((user) {
      _repository.fetchAllUsers(user).then((updatedList) {
        setState(() {
          usersList = updatedList;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.black,
              )),
          title: Text(
            'Чат',
            style: GoogleFonts.poppins(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: ChatSearch(usersList: usersList));
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: usersList.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ChatDetailScreen(
                                photoUrl: usersList[index].profileImageUrl,
                                name: usersList[index].name,
                                receiverUid: usersList[index].id,
                                myId: widget.myId,
                              ))));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(usersList[index].profileImageUrl),
                  ),
                  title: Text(usersList[index].name),
                ),
              ),
            );
          }),
        ));
  }
}

class ChatSearch extends SearchDelegate<String> {
  List<UserModel> usersList;
  ChatSearch({this.usersList});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
        color: Colors.black,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<UserModel> suggestionsList = query.isEmpty
        ? usersList
        : usersList.where((p) => p.name.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: ((context, index) => ListTile(
            onTap: () {
              //   showResults(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => ChatDetailScreen(
                            photoUrl: suggestionsList[index].profileImageUrl,
                            name: suggestionsList[index].name,
                            receiverUid: suggestionsList[index].id,
                          ))));
            },
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(suggestionsList[index].profileImageUrl),
            ),
            title: Text(suggestionsList[index].name),
          )),
    );
  }
}
