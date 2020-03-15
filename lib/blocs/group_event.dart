import 'package:equatable/equatable.dart';
import 'package:flutter_todo/models/group.dart';
// import 'package:flutter_todo/models/todo.dart';
// import 'package:flutter_todo/models/todo_group.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();

  @override
  List<Object> get props => [];
}

class LoadGroups extends GroupsEvent {}

class AddGroup extends GroupsEvent {
  final Group group;

  const AddGroup(this.group);

  @override
  List<Object> get props => [group];

  @override
  String toString() => 'AddGroup { group: $group }';
}

// class SelectGroup extends GroupsEvent {
//   final int groupID;

//   const SelectGroup(this.groupID);

//   List<Object> get props => [groupID];
// }

class DeleteGroups extends GroupsEvent {
  final Group group;

  const DeleteGroups(this.group);

  @override
  List<Object> get props => [group];
}