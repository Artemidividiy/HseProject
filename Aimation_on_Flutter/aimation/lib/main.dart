import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

class MyHomePage extends StatefulWidget{
  @override
  MyHomePageState createState() => MyHomePageState(); 
}

class MyHomePageState extends State<MyHomePage>{
  final title_style = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color : Colors.white24);

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
                width: 10.0,
                height: 10.0,
                child :
                  Image(
                    image: NetworkImage("https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg"),
                    color: Colors.white,
                  
                  ),
              ),
              Container( 
                padding : EdgeInsets.symmetric(vertical: 15.0),
                child :
              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  item_block("copy"),
                  item_block("share"),
                  item_block('settings')
                ],
              )
              ),
              taskList.TaskList(),
            ]
          )
      );           
    }
}
