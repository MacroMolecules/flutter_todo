
import 'package:flutter_todo/models/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoProvider {

  static Database db;

  static Future<void> insertTodo(Todo todo) async {
    print("insert");
    // 数据表里插入的数据
    // 多次插入 后一次插入的数据会覆盖之前的数据
    await db.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Todo>> todos() async {
    // 查询数据表 获取数据
    final List<Map<String, dynamic>> maps = await db.query('todos');

    // 将 List<Map<String, dynamic> 转换成 List<Todo> 数据类型
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  static Future<void> updateTodo(Todo todo) async {
    // 修改指定数据
    await db.update(
      'todos',
      todo.toMap(),
      // 匹配id
      where: "id = ?",
      // 通过 whereArg 传递 id 可以防止 SQL 注入
      whereArgs: [todo.id],
    );
  }

  static Future<void> deleteTodo(int id) async {
    // 移除
    await db.delete(
      'todos',
      where: "id = ?",
      whereArgs: [id],
    );
  }

}