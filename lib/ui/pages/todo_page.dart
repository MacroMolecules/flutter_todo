import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/todos_bloc.dart';
import 'package:flutter_todo/blocs/todos_event.dart';
import 'package:flutter_todo/database/group_provider.dart';
import 'package:flutter_todo/database/todo_provider.dart';
import 'package:flutter_todo/models/todo.dart';

class TodoPage extends StatefulWidget {
  TodoPage({this.todo, this.onTodoDeleted});

  final Todo todo;

  final Function() onTodoDeleted;

  @override
  State<StatefulWidget> createState() {
    return _TodoPageState();
  }
}

class _TodoPageState extends State<TodoPage> {
  bool _isEditing;

  @override
  void initState() {
    _isEditing = widget.todo.content.isEmpty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isEditing) {
      return Card(
        margin: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.edit),
          ),
          onSubmitted: (String content) {
            setState(() {
              widget.todo.content = content;
              _isEditing = false;
            });
          },
        ),
      );
    }

    return Card(
      margin: EdgeInsets.only(left: 25, top: 5, right: 25, bottom: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Dismissible(
        key: Key('key${widget.todo.content}'),
        child: ListTile(
          leading: Checkbox(
            value: widget.todo.isFinished == true,
            onChanged: (bool isFinished) {
              setState(() {
                widget.todo.isFinished = isFinished;
              });
            },
          ),
          title: GestureDetector(
            onDoubleTap: () async {
              await TodoProvider.updateTodo(widget.todo);
              setState(() {
                _isEditing = true;
              });
            },
            child: Text(
              widget.todo.content,
            ),
          ),
        ),
        onDismissed: (direction) async {
          var _snackStr;
          if (direction == DismissDirection.endToStart) {
            _snackStr = '删除了${widget.todo.content}';
          } else if (direction == DismissDirection.startToEnd) {
            _snackStr = '删除了${widget.todo.content}';
          }
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(_snackStr),
            duration: Duration(milliseconds: 400),
          ));
          await TodoProvider.deleteTodo(widget.todo.id);
          setState(() {
            widget.onTodoDeleted();
            // BlocProvider.of<TodosBloc>(context).add(DeleteTodo());
          });
        },
        background: Container(
          color: Colors.green,
          child: ListTile(
            leading: Icon(
              Icons.bookmark,
              color: Colors.white,
            ),
          ),
        ),
        secondaryBackground: Container(
          color: Colors.red,
          child: ListTile(
            trailing: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        confirmDismiss: (direction) async {
          var _confirmContent;
          var _alertDialog;
          if (direction == DismissDirection.endToStart) {
            _confirmContent = '确认删除${widget.todo.content}？';
            _alertDialog = _createDialog(
              _confirmContent,
              () {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('确认删除${widget.todo.content}'),
                    duration: Duration(milliseconds: 400),
                  ),
                );
                Navigator.of(context).pop(true);
              },
              () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('不删除${widget.todo.content}'),
                  duration: Duration(milliseconds: 400),
                ));
                Navigator.of(context).pop(false);
              },
            );
          } else if (direction == DismissDirection.startToEnd) {
            _confirmContent = '确认标记${widget.todo.content}？';
            _alertDialog = _createDialog(
              _confirmContent,
              () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('确认标记${widget.todo.content}'),
                  duration: Duration(milliseconds: 400),
                ));
                Navigator.of(context).pop(true);
              },
              () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('不标记${widget.todo.content}'),
                  duration: Duration(milliseconds: 400),
                ));
                Navigator.of(context).pop(false);
              },
            );
          }

          var isDismiss = await showDialog(
            context: context,
            builder: (context) {
              return _alertDialog;
            },
          );
          return isDismiss;
        },
      ),
    );
  }

  Widget _createDialog(
      String _confirmContent, Function sureFunction, Function cancelFunction) {
    return AlertDialog(
      content: Text(_confirmContent),
      actions: <Widget>[
        FlatButton(onPressed: sureFunction, child: Text('确认')),
        FlatButton(onPressed: cancelFunction, child: Text('取消')),
      ],
    );
  }
}
