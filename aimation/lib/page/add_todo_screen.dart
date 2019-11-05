import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:aimation/scopedmodel/todo_list_model.dart';
import 'package:aimation/model/todo_model.dart';
import 'package:aimation/utils/color_utils.dart';
import 'package:aimation/component/todo_badge.dart';
import 'package:aimation/model/hero_id_model.dart';

class AddTodoScreen extends StatefulWidget {
  final String taskId;
  final HeroId heroIds;

  AddTodoScreen({
    @required this.taskId,
    @required this.heroIds,
  });

  @override
  State<StatefulWidget> createState() {
    return _AddTodoScreenState();
  }
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  String newsubTask;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      newsubTask = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(
      builder: (BuildContext context, Widget child, TodoListModel model) {
        if (model.tasks.isEmpty) {
          // Loading
          return Container(
            color: Colors.white,
          );
        }

        var _subtask = model.tasks.firstWhere((it) => it.id == widget.taskId);
        var _color = ColorUtils.getColorFrom(id: _subtask.color);
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'new Subtask',
              style: TextStyle(color: _color),
            ),
            centerTitle: true,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black26),
            brightness: Brightness.light,
            backgroundColor: Colors.white,
          ),
          body: Container(
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What subtask are you planning to complete?',
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0),
                ),
                Container(
                  height: 16.0,
                ),
                TextField(
                  onChanged: (text) {
                    setState(() => newsubTask = text);
                  },
                  cursorColor: _color,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your Subtask...',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      )),
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 36.0),
                ),
                Container(
                  height: 26.0,
                ),
                Row(
                  children: [
                    TodoBadge(
                      codePoint: _subtask.codePoint,
                      color: _color,
                      id: widget.heroIds.codePointId,
                      size: 20.0,
                    ),
                    Container(
                      width: 16.0,
                    ),
                    Hero(
                      child: Text(
                        _subtask.name,
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      tag: "not_using_right_now", //widget.heroIds.titleId,
                    ),
                  ],
                )
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                heroTag: 'fab_new_subtask',
                icon: Icon(Icons.add),
                backgroundColor: _color,
                label: Text('Create Subtask'),
                onPressed: () {
                  if (newsubTask.isEmpty) {
                    final snackBar = SnackBar(
                      content: Text(
                          'please, enter the subtask name'),
                      backgroundColor: _color,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    model.addTodo(Todo(
                      newsubTask,
                      parent: _subtask.id,
                    ));
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

// Reason for wraping fab with builder (to get scafold context)
// https://stackoverflow.com/a/52123080/4934757
