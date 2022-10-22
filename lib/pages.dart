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
        title: Text("Translate app"),
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
