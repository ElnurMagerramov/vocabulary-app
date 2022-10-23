import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:localhost/db/dbhelper.dart';
import 'package:localhost/models/vacabulary.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int? selectedId;
  TextEditingController textController = TextEditingController();
  TextEditingController azTextController = TextEditingController();
  TextEditingController enTextController = TextEditingController();
  TextEditingController trTextController = TextEditingController();
  TextEditingController ruTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.new_label,
                size: 30.0,
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                "Add new word",
                style: TextStyle(fontSize: 30.0),
              ),
            ],
          )),
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
        ),
        body: ListView(children: [
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                TextField(
                  controller: textController,
                  decoration: InputDecoration(
                      hintText: "Add...",
                      label: Text("French:"),
                      prefixIcon: IconButton(
                          onPressed: () {
                            textController.text = "???";
                          },
                          icon: Icon(Icons.add)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            textController.clear();
                          },
                          icon: Icon(Icons.close))),
                ),
                TextField(
                  controller: azTextController,
                  decoration: InputDecoration(
                      hintText: "Add...",
                      label: Text("Azerbaijani:"),
                      prefixIcon: IconButton(
                          onPressed: () {
                            azTextController.text = "bir sey yaz";
                          },
                          icon: Icon(Icons.add)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            azTextController.clear();
                          },
                          icon: Icon(Icons.close))),
                ),
                TextField(
                  controller: ruTextController,
                  decoration: InputDecoration(
                      hintText: "Add...",
                      label: Text("Russian:"),
                      prefixIcon: IconButton(
                          onPressed: () {
                            ruTextController.text = "citay";
                          },
                          icon: Icon(Icons.add)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            ruTextController.clear();
                          },
                          icon: Icon(Icons.close))),
                ),
                TextField(
                  controller: enTextController,
                  decoration: InputDecoration(
                      hintText: "Add...",
                      label: Text("English:"),
                      prefixIcon: IconButton(
                          onPressed: () {
                            enTextController.text = "write something";
                          },
                          icon: Icon(Icons.add)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            enTextController.clear();
                          },
                          icon: Icon(Icons.close))),
                ),
                TextField(
                  controller: trTextController,
                  decoration: InputDecoration(
                      hintText: "Add...",
                      label: Text("Turkish:"),
                      prefixIcon: IconButton(
                          onPressed: () {
                            trTextController.text = "bir seyler yaz";
                          },
                          icon: Icon(Icons.add)),
                      suffixIcon: IconButton(
                          onPressed: () {
                            trTextController.clear();
                          },
                          icon: Icon(Icons.close))),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: TextButton(
                onPressed: addToDatabase,
                child: Center(
                    child: Text(
                  'Click to add',
                  style: TextStyle(color: Colors.white),
                ))),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: addToDatabase,
          child: Icon(Icons.plus_one),
        ));
  }

  void addToDatabase() async {
    selectedId != null
        ? await DbHelper.instance.update(
            Vocabulary(
                id: selectedId,
                french: textController.text,
                azerbaijani: azTextController.text,
                english: enTextController.text,
                russ: ruTextController.text,
                turkish: trTextController.text),
          )
        : await DbHelper.instance.add(
            Vocabulary(
                french: textController.text,
                azerbaijani: azTextController.text,
                english: enTextController.text,
                russ: ruTextController.text,
                turkish: trTextController.text),
          );
    setState(() {
      textController.clear();
      enTextController.clear();
      ruTextController.clear();
      azTextController.clear();
      trTextController.clear();
      selectedId = null;
    });
  }
}
