import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OldSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OldSearch();
  }
}

class _OldSearch extends State<OldSearch> {
  List fullData = [];
  List searchData = [];
  TextEditingController textEditingController = TextEditingController();
  @override
  initState() {
    super.initState();
    getLocalJsonData();
  }

  getLocalJson() {
    return rootBundle.loadString('lib/db/en-fr.json');
  }

  Future getLocalJsonData() async {
    final responce = json.decode(await getLocalJson());
    List tempList = [];
    for (var i in responce) {
      tempList.add(i);
    }
    fullData = tempList;
  }

  onSearchTextChanged(String text) async {
    searchData.clear();
    if (text.isEmpty) {
      return;
    }

    fullData.forEach((data) {
      if (data['French']
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase().toString())) {
        searchData.add(data);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: TextField(
            controller: textEditingController,
            onChanged: onSearchTextChanged,
            decoration: InputDecoration(
                hintText: "Search...",
                prefixIcon: Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () {
                      textEditingController.clear();
                    },
                    icon: Icon(Icons.close))),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: searchData.length == 0
                ? Center(child: Text("No search yet..."))
                : ListView.builder(
                    itemCount: searchData.length,
                    itemBuilder: (context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 2,
                            ),
                            Text(
                              "${searchData[index]['French']} --> ${searchData[index]['English']}",
                              style: TextStyle(fontSize: 15.0),
                            )
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      )),
    );
  }
}
