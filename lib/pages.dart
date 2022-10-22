import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:localhost/db/dbhelper.dart';
import 'package:localhost/models/vacabulary.dart';
import 'package:localhost/pages/add.dart';
import 'package:localhost/pages/allWords.dart';
import 'package:localhost/pages/search.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// class SQLite extends StatefulWidget {
//   const SQLite({super.key});

//   @override
//   State<SQLite> createState() => _SQLiteState();
// }

// class _SQLiteState extends State<SQLite> {
//   @override
//   Widget build(BuildContext context) {
//     return SearchPage();
//   }
// }

class SQLite extends StatefulWidget {
  const SQLite({super.key});

  @override
  State<SQLite> createState() => _SQLiteState();
}

class _SQLiteState extends State<SQLite> {
  int activePageNo = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Translate app"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Elnur Meherremov"),
              accountEmail: Text("elnur@gmail.com"),
              currentAccountPicture: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/picture.webp")
                        // NetworkImage('https://cdn.pixabay.com/photo/2016/03/26/22/13/man-1281562__340.jpg')
                            ,
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(title: Text("Add your new word"), onTap: () {}),
            ListTile(
              title: Text("Words"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Log out"),
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: PageView(
        // physics: NeverScrollableScrollPhysics(),
        onPageChanged: (displayPageNo) {
          setState(() {
            activePageNo = displayPageNo;
          });
        },
        controller: pageController,
        children: [AddPage(), AllWordsPage(), SearchPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day),
            label: 'Words',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        onTap: (selectedPageNo) {
          setState(() {
            print(selectedPageNo);
            activePageNo = selectedPageNo;
            pageController.jumpToPage(selectedPageNo);
          });
        },
        currentIndex: activePageNo,
      ),
    );
  }
}
