import 'package:flutter_todo/models/todo.dart';

class Tag {
  Tag({
    this.id,
    this.color,
    this.todos
  });

  final int id;
  String color;


  List<Todo> todos;
}