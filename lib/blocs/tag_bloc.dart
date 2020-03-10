import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/blocs/tag.dart';
import 'package:flutter_todo/models/todo_tag.dart';
import 'package:flutter_todo/blocs/tag.dart';
import 'package:flutter_todo/models/todo.dart';

class TagBloc extends Bloc<TagEvent, TodoTag> {
  @override
  TodoTag get initialState => TodoTag.todos;

  @override
  Stream<TodoTag> mapEventToState(TagEvent event) async* {
    if (event is UpdateTag) {
      yield event.tag;
    }
  }
}
