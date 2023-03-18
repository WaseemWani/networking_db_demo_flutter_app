import 'package:flutter/material.dart';
import 'DataModel.dart';
import 'NetworkManager.dart';
import 'dart:async';

class ListSample extends StatefulWidget {
  const ListSample({
    Key key,
  }) : super(key: key);

  @override
  _ListSampleState createState() => _ListSampleState();
}

class _ListSampleState extends State<ListSample> {
  Future<List<Todo>> todo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todo = NetworkManager().getData();
    print("hello from initstate...");
    print(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List View"),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todo,
        builder: (context, snapshot) {
          print('hey from builder');
          print(snapshot.data);
          if (snapshot.data != null) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return generateListItem(snapshot.data[index]);
              },
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.length,
              padding: EdgeInsets.all(20),
              separatorBuilder: (context, index) {
                return Divider(thickness: 1);
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget generateListItem(Todo todoData) {
    print('inside list creation function');
    print(todoData);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(todoData.title),
      Text(todoData.id.toString()),
    ]);
  }
}
