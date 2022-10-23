import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localhost/db/dbhelper.dart';
import 'package:localhost/models/vacabulary.dart';
import 'package:localhost/pages/oldVocabulary.dart';
import 'package:localhost/pages/yourVocabulary.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AllWordsPage extends StatefulWidget {
  const AllWordsPage({super.key});

  @override
  State<AllWordsPage> createState() => _AllWordsPageState();
}

class _AllWordsPageState extends State<AllWordsPage>
    with SingleTickerProviderStateMixin {
  late TabController controlTab;

  void initState() {
    super.initState();
    controlTab = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.language,
                size: 30.0,
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                "All words",
                style: TextStyle(fontSize: 30.0),
              ),
            ],
          )),
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
        ),
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
                    children: [YourVocabulary(), OldVocabulary()]),
              )
            ],
          ),
        ]));
  }
}
