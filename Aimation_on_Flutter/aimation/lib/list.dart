import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class TaskList extends StatefulWidget{
  @override
  TaskListState createState() =>  TaskListState();
}

class Data {
  final String title;
  final String subTitle;
  final int deadlineDate;
  Data(this.title, this.subTitle, this.deadlineDate);
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

  final _buttonStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20.0);
      

  Widget _buildListItem(BuildContext context, Data data){
    return ListTile(
      title: Text(data.title, style: _titleStyle,),
      subtitle: Text(data.subTitle, style : _subsStyle),
      leading: Text(data.deadlineDate.toString(), style: TextStyle(
        color: Colors.amberAccent[400],
        fontSize: 12.0,
        fontStyle: FontStyle.italic
      ),),
    );
  }
  
  List<Data>datas = [];

  @override
  Widget build(BuildContext context){
    if(datas.length == 0){
      return Align( 
        alignment: Alignment.bottomCenter,
        child: 
      Column(
        children: <Widget>[
          Text("no tasks for now", style: TextStyle(fontSize: 45.0),),
          Align( 
            alignment: Alignment.bottomCenter,
            child :
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children : <Widget>[
          RaisedButton(
                child: Text(
                  "add",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                      fontSize: 20.0),
                      ),
                color: Colors.amberAccent[400],
                onPressed: (){  
                  setState(() {
                    datas.add(Data("new task", "subs", 21));  
                  });
                },
          ),
          RaisedButton(
            child: 
              Text("add.",
              style : _buttonStyle,
              ),
            color: Colors.amberAccent[200],
            onPressed: (){
            _showModalBottomSheet(context);
          },)
              ]
            )
          )

        ],
      )
      );
    }

    return 
      Expanded(child: 
      Column(
        children: <Widget>[ 
        
          ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index){
            return Divider(height: 4,color: Colors.grey,);
          },
          itemCount: datas.length, 
          itemBuilder: (context, index) => _buildListItem(context, datas[index]),
        ), 
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children : <Widget>[ 
          RaisedButton(
                child: Text(
                  "fast add",
                  style: _buttonStyle,
                      ),
                color: Colors.amberAccent[600],
                onPressed: (){
                  setState(() {
                   datas.add(Data("new task", "subs", 21)); 
                  });
                  },
                  ),
          RaisedButton(
            child: Text(
              'add.',
              style : _buttonStyle),
            color: Colors.amberAccent[300],
            onPressed: (){
              _showModalBottomSheet(context);
            },
            ),
          
          RaisedButton(
            child: Text(
              "delete all",
              style: _buttonStyle
              ),
              color: Colors.amberAccent[200],
              onPressed: (){
                setState(() {
                 datas.clear(); 
                });
              },
              ),
         ]
        )
        ]
    )
    );
  }

  void _showModalBottomSheet(context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.text_fields),
                title: Text("title - newTask"),
                trailing : Icon(Icons.arrow_back_ios)
              ),
              ListTile(
                leading: Icon(Icons.text_fields),
                title: Text("subs - subs"),
                trailing : Icon(Icons.arrow_back_ios)
              ),
              ListTile(
                leading: Icon(Icons.access_alarm),
                title: Text("deadlineDate - 21"),
                trailing : Icon(Icons.arrow_back_ios)
              ),
              Container( child :
              IconButton(
                alignment: Alignment.bottomCenter,
                icon: Icon(Icons.add),
              onPressed: (){
                setState(() {
                  datas.add(Data("new Task", "subs", 21));
                  Navigator.pop(context);
                });
              },
              ) 
              )
            ],
          ),
        );
      }
    );
  }
}