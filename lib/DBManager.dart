import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'DataModel.dart';

class DBManager {
  DBManager.createInstance();
  static final DBManager dbManager = DBManager.createInstance();
  static Database _database;
  static bool isDatabaseEmpty = false;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();

    String path = join(directory.path, 'todo_database.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Todo('
          'userId INTEGER,'
          'id INTEGER,'
          'title String,'
          'completed BOOLEAN)');
    });
  }

  Future insert(Todo todo) async {
    final db = await database;
    var res = await db.insert('Todo', todo.toMap());
    return res;
  }

  Future<List<Todo>> retrieve() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Todo");
    if (res.isEmpty) {
      return [];
    } else {
      List<Todo> todoList =
          res.map<Todo>((json) => Todo.fromJson(json)).toList();
      return todoList;
    }
  }

  Future<bool> isEmpty() async {
    final db = await database;
    var count = await db.rawQuery("SELECT * FROM Todo");
    isDatabaseEmpty = count.isEmpty;
    return count.isEmpty;
  }
}
