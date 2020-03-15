import 'package:equatable/equatable.dart';
import 'package:flutter_todo/models/todo.dart';

// abstract class TodosEvent extends Equatable {
//   const TodosEvent();

//   @override
//   List<Object> get props => [];
// }

// // class LoadTodos extends TodosEvent {}

// class LoadTodos extends TodosEvent {
//   final int groupID;

//   const LoadTodos(this.groupID);
// }

// class ClearCompleted extends TodosEvent {}

// class ToggleAll extends TodosEvent {}

// 增强Equatable组件相等性判断的实现
abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodosEvent {
  final int groupID;

  const LoadTodos(this.groupID);
}

class AddTodo extends TodosEvent {
  final Todo todo;

  const AddTodo(this.todo);

  // props方法来返回todo的属性和值
  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodosEvent {
  final Todo updatedTodo;

  const UpdateTodo(this.updatedTodo);

  @override
  List<Object> get props => [updatedTodo];

//   @override
//   String toString() => 'UpdateTodo { updatedTodo: $updatedTodo }';
}

class DeleteTodo extends TodosEvent {
  final Todo todo;

  const DeleteTodo(this.todo);

  @override
  List<Object> get props => [todo];
}