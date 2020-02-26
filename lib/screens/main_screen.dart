import 'package:flutter/material.dart';
import 'package:list_and_remind/screens/tasks_screen.dart';
import 'package:list_and_remind/task.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Task> tasks = [];

  TextEditingController _textFieldController = TextEditingController();

  displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add List',style: TextStyle(color: Color(0xff321911)),),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "New List"),
              autofocus: true,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ACCEPT',textAlign: TextAlign.left,style: TextStyle(color: Color(0xff321911))),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                    tasks.add(new Task(_textFieldController.text),);
                    _textFieldController.clear();
                  });
                },
              ),
              FlatButton(
                child: Text('CANCEL',textAlign: TextAlign.right,style: TextStyle(color: Color(0xff321911))),
                onPressed: () {
                    Navigator.of(context).pop();
                    _textFieldController.clear();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayDialog(context),
        child: Icon(Icons.add, size: 28),
        backgroundColor: Color(0xff321911),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff321911),
        title: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'My Lists',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: Container(
        color: Color(0xffffc3b2),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            for (int i = 0; i < tasks.length; i++)
              FlatButton(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ListTile(
                      subtitle: Text(tasks[i].totalChecked()),
                      title: Text(
                        tasks[i].getName(),
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: FlatButton(
                        child: Icon(Icons.delete,color: Color(0xff321911)),
                        onPressed: () {
                          setState(() {
                            tasks.removeAt(i);
                          });
                        },
                      ),
                    ),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskManager(tasks[i])),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
