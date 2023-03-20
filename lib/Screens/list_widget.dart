import 'package:flutter/material.dart';
import 'package:networking_db_demo_flutter_app/DatabaseManager/DBManager.dart';
import '../Models/DataModel.dart';
import '../NetworkManager/NetworkManager.dart';
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
    super.initState();
    fetchData();
  }

  fetchData() async {
    var isDatabaseEmpty = await DBManager.dbManager.isEmpty();
    if (isDatabaseEmpty) {
      setState(() {
        todo = NetworkManager().getData();
      });
    } else {
      todo = DBManager.dbManager.retrieve();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todo,
        builder: (context, snapshot) {
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
    print(todoData);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(todoData.title),
      Row(children: [
        Text("Todo id"),
        SizedBox(width: 20),
        Text(todoData.id.toString())
      ])
    ]);
  }
}
