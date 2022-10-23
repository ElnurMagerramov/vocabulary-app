import 'package:flutter/material.dart';
import 'package:localhost/db/dbhelper.dart';
import 'package:localhost/models/vacabulary.dart';

class YourSearch extends StatefulWidget {
  const YourSearch({super.key});

  @override
  State<YourSearch> createState() => _YourSearchState();
}

class _YourSearchState extends State<YourSearch> {
  Future<List<Vocabulary>>? _searchResult;
  late Vocabulary word;
  int? selectedId;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextFormField(
            onFieldSubmitted: (value) {
              setState(() {
                _searchResult = DbHelper.instance.search(value);
              });
            },
            controller: textController,
            decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () {
                      textController.clear();
                    },
                    icon: Icon(Icons.close))),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
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
