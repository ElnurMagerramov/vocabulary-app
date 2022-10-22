import 'package:flutter/material.dart';
import 'dart:convert';

class OldVocabulary extends StatefulWidget {
  const OldVocabulary({super.key});

  @override
  State<OldVocabulary> createState() => _OldVocabularyState();
}

class _OldVocabularyState extends State<OldVocabulary> {
  List? data;
  List vocabulary = [
    "l’adolescence - adolescence",
    "l’âge de raison - grown-up age",
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('lib/db/en-fr.json'),
            builder: (context, snapshot) {
              var new_data = json.decode(snapshot.data.toString());
              return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xFFDFDFDF)),
                      left: BorderSide(color: Color(0xFFDFDFDF)),
                      right: BorderSide(color: Colors.black),
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 200,
                        padding: EdgeInsets.all(4.0),
                        child: new_data[index]['French'] == "French"
                            ? Text("${new_data[index]['French']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0))
                            : Text("${new_data[index]['French']}"),
                      ),
                      Container(
                        color: Colors.black,
                        width: 1.0,
                        height: 50.0,
                      ),
                      Container(
                        width: 200,
                        padding: EdgeInsets.all(4.0),
                        child: new_data[index]['English'] == "English"
                            ? Text("${new_data[index]['English']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0))
                            : Text("${new_data[index]['English']}"),
                      )
                    ],
                  ),
                );
              });
            }));
  }
}
