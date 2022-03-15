import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'basic.dart';

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: inicio(),
    );
  }
}

class inicio extends StatefulWidget {
  inicio({Key? key}) : super(key: key);

  @override
  State<inicio> createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  TextEditingController titleController = TextEditingController();
  Future<String> getData() async {
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "aplication/json"});
    List map = json.decode(response.body);
    var basic = Basic.fromJson(map[1]);
    print(basic.title);
    titleController.text = 'Titulo '+ basic.title.toString(); 
    return 'okey';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GutierrezApp'),
      ),
      body: ListView(children: <Widget>[
        Text("Programa manual"),
      TextFormField(
        controller: titleController,
        readOnly: true,
        decoration: InputDecoration(hintText: "Title",
        border:InputBorder.none),
      ),
        ElevatedButton(
            onPressed: getData, child: new Text('Llamando a servicio web'))
      ]),
    );
  }
}
