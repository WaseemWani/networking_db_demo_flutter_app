import 'dart:convert';
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
      var listData = data as List;
      todos = listData.map<Todo>((json) => Todo.fromJson(json)).toList();
      print(listData.length);
      return todos;
    } else {
      print("error occured");
    }
  }
}
