import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/widgets.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

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

Widget _tile(String title, int days, IconData ic){
  return ListTile(
    title: Text(title,
    style : title_style,
    ),
    subtitle: Text('${days} days to next dedline',
     style: TextStyle(
       fontFamily: 'Roboto',
       fontSize: 8.0,
       color: Colors.amberAccent[400]
     ),
     ),
     leading: Icon(
       ic,
       color : Colors.amberAccent[400]
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
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              children: <Widget>[
                const Text('I\'m dedicating every day to you'),
                const Text('Domestic life was never quite my style'),
                const Text('When you smile, you knock me out, I fall apart'),
                const Text('And I thought I was so smart'),
              ],
            ),
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