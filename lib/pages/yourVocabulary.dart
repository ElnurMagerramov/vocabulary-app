import 'package:flutter/material.dart';
import 'package:localhost/db/dbhelper.dart';
import 'package:localhost/models/vacabulary.dart';

class YourVocabulary extends StatefulWidget {
  const YourVocabulary({super.key});

  @override
  State<YourVocabulary> createState() => _YourVocabularyState();
}

class _YourVocabularyState extends State<YourVocabulary> {
  int? selectedId;
  @override
  Widget build(BuildContext context) {
    return      
       Center(
          child: FutureBuilder<List<Vocabulary>>(
              future: DbHelper.instance.getvocabulary(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Vocabulary>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text('Loading...'));
                }
                return snapshot.data!.isEmpty
                    ? Center(child: Text('No Words in your vacabulary.'))
                    : ListView(
                        children: snapshot.data!.map((Vocabulary) {
                          return Center(
                            child: Card(
                              color: selectedId == Vocabulary.id
                                  ? Colors.white70
                                  : Colors.white,
                              child: ListTile(
                                  title: Text(
                                    Vocabulary.french,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Vocabulary.azerbaijani.trim() != ""
                                          ? Text(
                                              "Azerbaijani: ${Vocabulary.azerbaijani}")
                                          : SizedBox(
                                              height: 0,
                                            ),
                                      Vocabulary.english.trim() != ""
                                          ? Text(
                                              "English: ${Vocabulary.english}")
                                          : SizedBox(
                                              height: 0,
                                            ),
                                      Vocabulary.turkish.trim() != ""
                                          ? Text(
                                              "Turkish: ${Vocabulary.turkish}")
                                          : SizedBox(
                                              height: 0,
                                            ),
                                      Vocabulary.russ.trim() != ""
                                          ? Text("Russian: ${Vocabulary.russ}")
                                          : SizedBox(
                                              height: 0,
                                            ),
                                    ],
                                  ),
                                  onLongPress: () {
                                    setState(() {
                                      DbHelper.instance.remove(Vocabulary.id!);
                                    });
                                  },
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        DbHelper.instance
                                            .remove(Vocabulary.id!);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red[700],
                                    ),
                                  )),
                            ),
                          );
                        }).toList(),
                      );
              }),
        );
  }
}