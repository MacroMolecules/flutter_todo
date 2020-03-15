// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_todo/blocs/todos_bloc.dart';
// import 'package:flutter_todo/blocs/todos_state.dart';
// import 'package:flutter_todo/ui/pages/create_todo.dart';
// import 'package:flutter_todo/ui/widgets/bottom_sheet.dart';

// class TodoList extends StatefulWidget {
// //   TodoList({Key key}) : super(key: key);

//   @override
//   _TodoListState createState() => _TodoListState();
// }

// class _TodoListState extends State<TodoList> {

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TodosBloc, TodosState>(
//       builder: (context, state) {

//         if (state is TodosLoaded) {
//           return _buildTodoList(context, state.todo);
//         }
//         return Center(child: Text(""));
//       }
//     );
//   }

//   Widget _buildTodoList(BuildContext context, List<TodoList> todos) {
//     return Scaffold(
//       // 底部浮动按钮
//       floatingActionButton: FloatingActionButton(
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//         onPressed: () {
//           _addTask(context);
//         },
//       ),
//     );
//   }

//   void _addTask(BuildContext context) {
//     showModalBottomSheetApp(
//       context: context,
//       builder: (BuildContext bc) {
//         return Container(
//           // 无弹窗部分颜色
//           color: Color(0xFF737373),
//           child: Container(
//             // 弹窗背景
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10.0),
//                 topRight: Radius.circular(10.0),
//               ),
//             ),
//             child: CreateTodo(),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/todos_bloc.dart';
import 'package:flutter_todo/blocs/todos_event.dart';
import 'package:flutter_todo/blocs/todos_state.dart';
import 'package:flutter_todo/database/todo_provider.dart';
import 'package:flutter_todo/models/group.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/ui/pages/todo_page.dart';

class TodoList extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();
  Group _group;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(builder: (context, state) {
      if (state is TodosLoaded) {
        return _buildTodoList(context, state.todos);
      }
      return Center(child: Text("没有待办事项"));
    });
  }

  Widget _buildTodoList(BuildContext context, List<Todo> todos) {
    return Column(
      children: <Widget>[
        Card(
          margin: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.text_fields),
              hintText: "输入新的事项",
            ),
            onSubmitted: (String content) async {
              if (content.isEmpty) {
                return;
              }
              var newTodo = Todo(
                id: null,
                content: content,
                isFinished: false,
                createdAt: 11,
              );
              await TodoProvider.insertTodo(newTodo);
              setState(() {
                _group.todos.add(newTodo);
              });
              // Todo newTodo = Todo();
              BlocProvider.of<TodosBloc>(context).add(AddTodo(newTodo));
              _textFieldController.clear();
            },
          ),
        ),
        ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            final todo = todos[index];
            return TodoPage(
              todo: todo,
              onTodoDeleted: () {
                BlocProvider.of<TodosBloc>(context).add(DeleteTodo(todo));
              },
            );
          },
          itemCount: todos.length,
          shrinkWrap: true,
        ),
      ],
    );
  }

  void setState(Null Function() param0) {}
}
