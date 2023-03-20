import 'dart:convert';
import 'package:networking_db_demo_flutter_app/DBManager.dart';
import 'DataModel.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class NetworkManager {
  Future<List<Todo>> getData() async {
    List<Todo> todos;
    final response =
        await http.get('https://jsonplaceholder.typicode.com/todos');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(data);
      var listData = data as List;
      saveToDB(listData);
      todos = listData.map<Todo>((json) => Todo.fromJson(json)).toList();
      print(listData.length);
      return todos;
    } else {
      print("error occured");
    }
  }

  saveToDB(List todoList) {
    todoList.map((todo) {
      DBManager.dbManager.insert(Todo.fromJson(todo));
    }).toList();
  }
}
