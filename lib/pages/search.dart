import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localhost/db/dbhelper.dart';
import 'package:localhost/models/vacabulary.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<List<Vocabulary>>? _searchResult;
  late Vocabulary word;
  int? selectedId;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.search),
          title: TextFormField(
            onFieldSubmitted: (value) {
              setState(() {
                _searchResult = DbHelper.instance.search(value);
              });
            },
            controller: textController,
            decoration: InputDecoration(hintText: "Search..."),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [
            IconButton(
                onPressed: () {
                  textController.clear();
                },
                icon: Icon(Icons.close))
          ],
        ),
        body: _searchResult != null ? getResults() : hasNotSearch());
  }

  Widget hasNotSearch() {
    return Center(child: Text("Search word..."));
  }

  Center getResults() {
    return Center(
        child: FutureBuilder<List<Vocabulary>>(
            future: _searchResult,
            builder: (BuildContext context,
                AsyncSnapshot<List<Vocabulary>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data?.length == 0) {
                return Center(
                  child: Text("There is not result..."),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    word = snapshot.data![index];
                    // if ("${word.french}" == textController.text) {
                    return wordLine(word);
                    // } else {
                    //   return null;
                    // }
                  },
                );
              }
            }));
  }

  wordLine(Vocabulary word) {
    return ListTile(
        title: Text(word.french),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            word.azerbaijani.trim() != ""
                ? Text("Azerbaijani: ${word.azerbaijani}")
                : SizedBox(
                    height: 0,
                  ),
            word.english.trim() != ""
                ? Text("English: ${word.english}")
                : SizedBox(
                    height: 0,
                  ),
            word.turkish.trim() != ""
                ? Text("Turkish: ${word.turkish}")
                : SizedBox(
                    height: 0,
                  ),
            word.russ.trim() != ""
                ? Text("Russian: ${word.russ}")
                : SizedBox(
                    height: 0,
                  ),
          ],
        ),
        onTap: () {
          setState(() {
            if (selectedId == null) {
              textController.text = word.french;
              selectedId = word.id;
            } else {
              textController.text = '';
              selectedId = null;
            }
          });
        },
        onLongPress: () {
          setState(() {
            DbHelper.instance.remove(word.id!);
          });
        });
  }
}
