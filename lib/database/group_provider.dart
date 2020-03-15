import 'package:flutter_todo/models/group.dart';
import 'package:sqflite/sqflite.dart';

class GroupProvider {

  static Database db;

  static Future<List<Group>> Groups() async {
    final List<Map<String, dynamic>> maps = await db.query('groups');
    return List.generate(maps.length, (i) {
      return Group.fromMap(maps[i]);
    });
  }

  static Future <void> insertGroup(Group group) async {
    await db.insert(
      'groups',
      group.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // static Future<void> updateGroup(Group group) async {
  //   await db.update(
  //     'group',
  //     group.toMap(),
  //     where: "id = ?",
  //     whereArgs: [group.id],
  //   );
  // }

  static Future<void> deleteGroup(int id) async {
    // 移除
    await db.delete(
      'categroups',
      where: "id = ?",
      whereArgs: [id],
    );
  }

}