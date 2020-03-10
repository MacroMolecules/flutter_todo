import 'package:equatable/equatable.dart';
import 'package:flutter_todo/models/todo.dart';
import 'package:flutter_todo/models/todo_tag.dart';

abstract class TagEvent extends Equatable {
  const TagEvent();
}

class UpdateTag extends TagEvent {
  final TodoTag tag;

  const UpdateTag(this.tag);

  @override
  List<Object> get props => [tag];

  @override
  String toString() => 'UpdateTag { tag: $tag }';
}
