import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String task = "";
  List<String> tasks = [];
  List<String> picks = ["a", "b", "c", "d", "e", "f", "g", "h"];
  int selectedPick = 0;

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Popup'),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[Text(task)]),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                final item = tasks[index];
                return Dismissible(
                  key: Key(item),
                  onDismissed: (direction) {
                    setState(() {
                      tasks.removeAt(index);
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('$item removed')));
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                    title: Text(item),
                  ),
                );
                //return new Text(tasks[index]);
              },
            )),
            TextField(
                onChanged: (text) {
                  task = text;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter a Task')),
            ElevatedButton(
                onPressed: () {
                  tasks.add(task);
                  setState(() {});
                },
                child: const Text("Add")),
            Expanded(
                child: ListView.builder(
                    itemCount: picks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Material(
                          child: ListTile(
                              title: Text(picks[index]),
                              tileColor: selectedPick == index
                                  ? Colors.lightBlueAccent
                                  : null,
                              onTap: () {
                                setState(() {
                                  selectedPick = index;
                                });
                              }));
                    })),
            ElevatedButton(
                onPressed: () {
                  var rng = new Random();
                  selectedPick = rng.nextInt(picks.length);
                  setState(() {});
                },
                child: const Text("Random Pick"))
          ],
        ),
      ),
    );
  }
}
