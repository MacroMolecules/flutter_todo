import 'package:equatable/equatable.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/ui/pages/todo_list.dart';

// 定义需要处理的不同状态
abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

// 从存储库中获取待办事项的状态
class TodosLoading extends TodosState {}

// 待办事项成功加载后的状态
class TodosLoaded extends TodosState {
  final List<Todo> todos;

  const TodosLoaded([this.todos = const []]);

  @override
  List<Object> get props => [todos];

  // List<TodoList> get todo => null;

//   @override
//   String toString() => 'TodosLoaded { todos: $todos }';
}

// 如果待办事项未成功加载的状态
class TodosNotLoaded extends TodosState {}
