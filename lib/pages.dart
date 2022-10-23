import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localhost/pages/add.dart';
import 'package:localhost/pages/allWords.dart';
import 'package:localhost/pages/search.dart';

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
                        image: AssetImage("images/picture.webp"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
                title: Text("Add your new word"),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => AddPage(),
                      ));
                }),
            ListTile(
              title: Text("Words"),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AllWordsPage(),
                    ));
              },
            ),
            ListTile(
              title: Text("Search"),
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SearchPage(),
                    ));
              },
            ),
            ListTile(
              title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                      child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ))),
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
