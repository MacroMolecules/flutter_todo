import 'package:equatable/equatable.dart';

class Todo extends Equatable {

  Todo({
    this.id,
    this.content,
    this.isFinished,
    this.createdAt,
  });

  final int id;
  String content;
  bool isFinished;
  int createdAt;

  @override
  List<Object> get props => [id, content, isFinished, createdAt];

  static Todo fromMap(Map<String, dynamic> data) {
    return Todo(
      id: data['id'],
      content: data['content'],
      isFinished: data['isFinished'].toString() == "1",
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isFinished': isFinished,
      'createdAt': createdAt,
    };
  }

  @override
  String toString() {
    return 'Todo{id: $id, content: $content, isFinished: $isFinished}, createdAt: $createdAt}';
  }

}