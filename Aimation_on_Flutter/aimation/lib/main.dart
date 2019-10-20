import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart';
import 'package:clipboard_manager/clipboard_manager.dart';
import 'list.dart' as taskList;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return MaterialApp(
      title : "aimation.",
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      );
  }
}

List<String> titles;
List<int> days;
List<IconData> icons;

class MyHomePage extends StatelessWidget{
  Widget item_block(String text){
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          child : Icon(
            Icons.add,
            color : Colors.pinkAccent[400],   
          )
        ),
        Text(text)
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    
  return Scaffold(
      appBar: AppBar(
        title: Text("profile",
         style: title_style),
        backgroundColor: Colors.black87,
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top : 1200.0),
              width: 32.0,
              height: 32.0,
              child :
                Image(
                  image: NetworkImage("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                  color: Colors.white,
                
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                item_block("copy"),
                item_block("share"),
                item_block('settings')
              ],
            ),
            taskList.TaskList(),
            RaisedButton(
              child: Text(
                "add",
                 style: TextStyle(
                   fontFamily: 'Roboto',
                    fontSize: 8.0),
                    ),
              color: Colors.amberAccent[400],
              onPressed: (){
                showBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    color: Colors.amberAccent[400],
                  ));
                  },
                )
          ]
        )
    );
              
  }
  
}
final title_style = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color : Colors.white24);