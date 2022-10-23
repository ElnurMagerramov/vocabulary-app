import 'dart:convert';
import 'dart:io';
import 'package:localhost/models/vacabulary.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._privateConstruvtor();
  static final DbHelper instance = DbHelper._privateConstruvtor();

  static Database? _db;
  Future<Database> get db async => _db ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'vocabulary.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE vocabulary(
          id INTEGER PRIMARY KEY,
          french TEXT,
          azerbaijani TEXT,
          russ TEXT,
          english TEXT,
          turkish TEXT
      )
      ''');
  }

  Future<List<Vocabulary>> getvocabulary() async {
    Database db = await instance.db;
    var vocabulary = await db.query('vocabulary', orderBy: 'french');
    List<Vocabulary> VocabularyList = vocabulary.isNotEmpty
        ? vocabulary.map((c) => Vocabulary.fromMap(c)).toList()
        : [];
    return VocabularyList;
  }

  Future<List<Vocabulary>> search(word) async {
    Database db = await instance.db;
    var vocabulary =
        await db.rawQuery('SELECT * FROM vocabulary WHERE french="$word";');
    List<Vocabulary> VocabularyList = vocabulary.isNotEmpty
        ? vocabulary.map((c) => Vocabulary.fromMap(c)).toList()
        : [];
    return VocabularyList;
  }

  Future<int> add(Vocabulary Vocabulary) async {
    Database db = await instance.db;
    return await db.insert('vocabulary', Vocabulary.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.db;
    return await db.delete('vocabulary', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Vocabulary Vocabulary) async {
    Database db = await instance.db;
    return await db.update('vocabulary', Vocabulary.toMap(),
        where: "id = ?", whereArgs: [Vocabulary.id]);
  }
}
