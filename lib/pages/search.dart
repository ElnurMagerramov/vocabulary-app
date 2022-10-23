import 'package:flutter/material.dart';
import 'package:localhost/pages/oldSearch.dart';
import 'package:localhost/pages/yourSearch.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController controlTab;

  void initState() {
    super.initState();
    controlTab = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Column(
          children: [
            TabBar(
                controller: controlTab,
                indicatorColor: Colors.blue[800],
                labelColor: Colors.blue[800],
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs: [
                  Tab(child: Text("Your Vocabulary")),
                  Tab(child: Text("French-English")),
                ]),
            Container(
              height: 450.0,
              child: TabBarView(
                  controller: controlTab,
                  children: [YourSearch(), OldSearch()]),
            )
          ],
        ),
      ]),
    );
  }
}
