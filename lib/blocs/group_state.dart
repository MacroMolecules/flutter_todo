import 'package:equatable/equatable.dart';
import 'package:flutter_todo/models/group.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object> get props => [];
}

class GroupsLoading extends GroupsState { }

// class GroupSelected extends GroupsState {
//   final int groupID;

//   const GroupSelected(this.groupID);
// }

class GroupsLoaded extends GroupsState {

  final List<Group> groups;

  const GroupsLoaded([this.groups = const []]);

  @override
  List<Object> get props => [groups];
}

class GroupsNotLoaded extends GroupsState { }