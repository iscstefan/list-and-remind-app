import 'package:flutter/material.dart';
import 'package:list_and_remind/task.dart';
import 'package:list_and_remind/activity.dart';

class TaskManager extends StatefulWidget {
  final Task task;

  TaskManager(this.task);

  @override
  _TaskManagerState createState() => _TaskManagerState(task);
}

class _TaskManagerState extends State<TaskManager> {
  Task task;
  _TaskManagerState(this.task);

  TextEditingController _textFieldController = TextEditingController();

  displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Add Task',
              style: TextStyle(color: Color(0xff321911)),
            ),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "New Task"),
              autofocus: true,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ACCEPT',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Color(0xff321911))),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                    task.activities
                        .add(new Activity(_textFieldController.text));
                    _textFieldController.clear();
                  });
                },
              ),
              FlatButton(
                child: Text('CANCEL',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Color(0xff321911))),
                onPressed: () {
                  Navigator.of(context).pop();
                  _textFieldController.clear();
                },
              )
            ],
          );
        });
  }

  Color changeColor(int i) {
    if (task.activities[i].isChecked)
      return Color(0xffffc3b2);
    else
      return Colors.white;
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
        title: Text(task.getName()),
        backgroundColor: Color(0xff321911),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check, size: 25),
            onPressed: () {
              setState(() {
                task.checkAll();
              });
            },
          ),
          //SizedBox(width: 5),
          IconButton(
            icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  task.uncheckAll();
                });
              }
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Container(
        color: Color(0xffffc3b2),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            for (int i = 0; i < task.activities.length; i++)
              Container(
                child: Card(
                  color: changeColor(i),
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: task.activities[i].isChecked,
                        activeColor: Color(0xff321911),
                        onChanged: (context) {
                          setState(() {
                            task.activities[i].isChecked =
                                !task.activities[i].isChecked;
                          });
                        },
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(
                            task.activities[i].name,
                            style: TextStyle(fontSize: 18),
                          ),
                          trailing: FlatButton(
                            child: Icon(Icons.delete, color: Color(0xff321911)),
                            onPressed: () {
                              setState(() {
                                task.activities.removeAt(i);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                ),
              ),
          ],
        ),
      ),
      backgroundColor: Color(0xffffc3b2),
    );
  }
}
