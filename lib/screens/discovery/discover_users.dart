import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertravelman/models/user_data.dart';
import 'package:fluttertravelman/models/user_model.dart';
import 'package:fluttertravelman/screens/profile/profile_screen.dart';
import 'package:fluttertravelman/services/firebase_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot> _users;

  _buildUserTile(UserModel user) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20.0,
        backgroundImage: user.profileImageUrl.isEmpty
            ? AssetImage('assets/images/user_placeholder.jpg')
            : CachedNetworkImageProvider(user.profileImageUrl),
      ),
      title: Text(user.name),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileScreen(
            currentUserId: Provider.of<UserData>(context).currentUserId,
            userId: user.id,
          ),
        ),
      ),
    );
  }

  _clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
    setState(() {
      _users = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintText: 'Поиск',
            prefixIcon: Icon(
              Icons.search,
              size: 30.0,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: _clearSearch,
            ),
            filled: true,
          ),
          onSubmitted: (input) {
            if (input.isNotEmpty) {
              setState(() {
                _users = FirebaseProvider.searchUsers(input);
              });
            }
          },
          cursorColor: Colors.black,
        ),
      ),
      body: _users == null
          ? Center(
              child: Text('Поиск пользователей, с учетом регистра букв'),
            )
          : FutureBuilder(
              future: _users,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data.documents.length == 0) {
                  return Center(
                    child: Text('Не найдено! Регистры букв долны совпадать'),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (BuildContext context, int index) {
                    UserModel user =
                        UserModel.fromDoc(snapshot.data.documents[index]);
                    return _buildUserTile(user);
                  },
                );
              },
            ),
    );
  }
}
