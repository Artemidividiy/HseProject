import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskList extends StatefulWidget{
  @override
  TaskListState createState() =>  TaskListState();
}

class Data {
  final String title;
  final String subTitle;
  final int deadlineDate;
  final DocumentReference reference;

  Data(this.title, this.subTitle, this.deadlineDate, this.reference);
}

class TaskListState extends State<TaskList>{
  final _titleStyle = TextStyle(
    fontFamily: 'Roboto',
    color: Colors.amberAccent[200],
    fontSize: 20.0
  );

  final _subsStyle = TextStyle(
    fontSize: 8.0,
    color: Colors.amberAccent[300],
  );

  Widget _buildListItem(BuildContext context, Data data){
    return ListTile(
      title: Text(data.title, style: _titleStyle,),
      subtitle: Text(data.subTitle, style : _subsStyle),
      trailing: Text(data.deadlineDate.toString(), style: TextStyle(
        color: Colors.amberAccent[400],
        fontSize: 12.0,
        fontStyle: FontStyle.italic
      ),),
    );
  }
  @override
  Widget build(BuildContext context){
    return Container(
        child: StreamBuilder(
          stream: Firestore.instance.collection('users/user_one/tasks/task1').snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData) return Text("loading...", style : TextStyle(fontSize: 40.0));
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder : (context, index) =>
                _buildListItem(context, snapshot.data.documents[index])
            );
          }
        )
    );
  }
        
}
