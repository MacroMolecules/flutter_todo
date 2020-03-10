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
            fontSize: 25.0,
            color: Colors.white,
          ),
        ),
        // 首页顶部侧栏
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.dehaze),
              onPressed: () {},
            );
          },
        ),
        // 去除首页顶栏下的阴影
        elevation: 0.0,
      ),
      body: TodoList(),
    );
  }
}
