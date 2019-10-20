import 'package:flutter/material.dart';
import 'dart:async';
import 'package:aimation/tasks.json';
import 'package:http/http.dart' as http;

class TaskList extends StatefulWidget{
  @override
  TaskListState createState() =>  TaskListState();
}

class Data{
  final int index;
  final String title;
  final int deadlineDate;

  Data(this.index, this.title, this.deadlineDate);
}


class TaskListState extends State<TaskList>{
  Future<List<Data>> _getData() async {
    var data = await http.get()
  }

  final _listTile = ListTile(
    leading: Icon(
      Icons.add,
    ),
    title: ,
  )
  
  @override
  Widget build(BuildContext context){
    return ListView.builder(  
      
    );
  }
}