import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:aimation/scopedmodel/todo_list_model.dart';
import 'package:aimation/model/task_model.dart';
import 'package:aimation/component/iconpicker/icon_picker_builder.dart';
import 'package:aimation/component/colorpicker/color_picker_builder.dart';
import 'package:aimation/utils/color_utils.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen();

  @override
  State<StatefulWidget> createState() {
    return _AddTaskScreenState();
  }
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newTask;
  DateTime newdeadlineDate;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color taskColor;
  IconData taskIcon;

  @override
  void initState() {
    super.initState();
    setState(() {
      newTask = '';
      newdeadlineDate = DateTime(2045, 1, 1);
      taskColor = ColorUtils.defaultColors[0];
      taskIcon = Icons.work;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodoListModel>(
      builder: (BuildContext context, Widget child, TodoListModel model) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'New Task',
              style: TextStyle(color: taskColor),
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
                  'Task are your global ideas, which you want to achieve, and which containes multiples of subtasks',
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
                    setState(() => newTask = text);
                  },
                  cursorColor: taskColor,
                  autofocus: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Task Name...',
                      hintStyle: TextStyle(
                        color: Colors.black26,
                      )),
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 36.0),
                ),
                Container(
                  height: 12,
                ),
                Row(
                  children: [
                    ColorPickerBuilder(
                        color: taskColor,
                        onColorChanged: (newColor) =>
                            setState(() => taskColor = newColor)),
                    Container(
                      width: 22.0,
                    ),
                    IconPickerBuilder(
                        iconData: taskIcon,
                        highlightColor: taskColor,
                        action: (newIcon) =>
                            setState(() => taskIcon = newIcon)),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Builder(
            builder: (BuildContext context) {
              return FloatingActionButton.extended(
                heroTag: 'fab_new_card',
                icon: Icon(Icons.save),
                backgroundColor: taskColor,
                label: Text('Create New Task'),
                onPressed: () {
                  if (newTask.isEmpty) {
                    final snackBar = SnackBar(
                      content: Text(
                          'Ummm... It seems that you are trying to add an invisible task, it\'s cheating...'),
                      backgroundColor: taskColor,
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState.showSnackBar(snackBar);
                  } else {
                    model.addTask(Task(newTask,
                        codePoint: taskIcon.codePoint, color: taskColor.value));
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
