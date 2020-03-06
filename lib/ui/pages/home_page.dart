import 'package:flutter/material.dart';
import 'package:flutter_todo/ui/pages/todo_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 首页顶栏
      appBar: AppBar(
        title: Text(
          '待办事项',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            ),
        ),
      ),
      body: TodoList(),
    );
  }
}
