import 'package:flutter_todo/models/todo.dart';

class Group {
  Group({
    this.id,
    this.name,
    this.todos
  });

  final int id;
  String name;

  List<Todo> todos;

  @override
  List<Object> get props => [id, name, todos];

  static Group fromMap(Map<String, dynamic> data) {
    return Group(
      id: data['id'],
      name: data['name'],
      todos: data['todos'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'todos': todos,
    };
  }

  @override
  String toString() {
    return 'Group{id: $id, name: $name, todos: $todos}';
  }

}