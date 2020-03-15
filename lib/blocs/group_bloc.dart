// import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/blocs/group_event.dart';
import 'package:flutter_todo/blocs/group_state.dart';
import 'package:flutter_todo/models/group.dart';

// 分类默认列表
var groups = <Group>[
  Group(id: 1, name: "默认", todos: null),
];

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  @override
  GroupsState get initialState => GroupsNotLoaded();

  @override
  Stream<GroupsState> mapEventToState(GroupsEvent event) async* {
    if (event is LoadGroups) {
      // yield*的作用是将 yield 后面的所有元素插入到当前创建的序列中，而不是创建新的序列
      yield* _mapLoadGroups();
    } else if (event is AddGroup) {
      yield* _mapAddGroups(event);
    } else if (event is DeleteGroups) {
      yield* _mapDeleteGroup(event);
    }
  }

  Stream<GroupsState> _mapLoadGroups() async* {
    yield GroupsLoaded(groups);
  }

  // 告诉Bloc需要将新的分类添加到分类列表中
  Stream<GroupsState> _mapAddGroups(AddGroup event) async* {
    if (state is GroupsLoaded) {
      final List<Group> updatedGroups = List.from((state as GroupsLoaded).groups)
        ..add(event.group);
      yield GroupsLoaded(updatedGroups);
    }
  }

  // 告诉Bloc它需要删除现有的分类
  // 当执行到yield修饰的位置的时候，会将yield修饰的表达式的运算结果添加到Stream数据流中
  Stream<GroupsState> _mapDeleteGroup(DeleteGroups event) async* {
    if (state is GroupsLoaded) {
      final List<Group> updatedGroups = List.from((state as GroupsLoaded).groups)
        ..remove(event.group);
      // yield语句传递值
      yield GroupsLoaded(updatedGroups);
    }
  }

  // Stream<GroupsState> _mapSelectGroup(int groupID) async* {
  //   yield GroupSelected(groupID);
  // }
}