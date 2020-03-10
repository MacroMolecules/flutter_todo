import 'package:flutter/material.dart';
import 'package:flutter_todo/models/todo_tag.dart';
import 'package:flutter_todo/ui/pages/create_todo.dart';
import 'package:flutter_todo/ui/widgets/bottom_sheet.dart';

class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: StreamBuilder<List<TodoTag>>(
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       if (snapshot.data.length > 0) {
      //         // 滚动组件
      //         return Card(
      //           child: ListView(

      //           ),
      //         );
      //       } else {
      //         return Container(
      //           child: Center(
      //             child: Text("没有待办事项"),
      //           ),
      //         );
      //       }
      //     }
      //   },
      // ),
      // 底部浮动按钮
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _addTask(context);
        },
      ),
    );
  }

  void _addTask(BuildContext context) {
    showModalBottomSheetApp(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          // 无弹窗部分颜色
          color: Color(0xFF737373),
          child: Container(
            // 弹窗背景
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: CreateTodo(),
          ),
        );
      },
    );
  }
}
