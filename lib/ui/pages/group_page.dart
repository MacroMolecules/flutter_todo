import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/group_bloc.dart';
import 'package:flutter_todo/blocs/group_event.dart';
import 'package:flutter_todo/blocs/group_state.dart';
import 'package:flutter_todo/database/todo_provider.dart';
import 'package:flutter_todo/models/group.dart';

class GroupPage extends StatefulWidget {
  GroupPage({this.group, this.onGroupDeleted});

  final Group group;

  final Function() onGroupDeleted;

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  _GroupPageState({this.group, this.onGroupDeleted});

  final Group group;
  final Function() onGroupDeleted;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
        if (state is GroupsLoaded) {
          final groups = state.groups;
          return ListView.builder(
            itemBuilder: (context, index) {
              final group = groups[index];
              return Card(
                child: Dismissible(
                  key: Key('key${[index]}'),
                  child: ListTile(
                    title: GestureDetector(
                      child: Text(
                        group.name,
                      ),
                    ),
                    onTap: () {
                      BlocProvider.of<GroupsBloc>(context).add(LoadGroups());
                      Navigator.pop(context);
                    },
                  ),
                  onDismissed: (direction) async {
                    // 定义提示
                    var _promptBar;
                    if (direction == DismissDirection.endToStart) {
                      _promptBar = '删除了${[index]}';
                    } else if (direction == DismissDirection.startToEnd) {
                      _promptBar = '删除了${[index]}';
                    }
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        // 弹出提示语句
                        content: Text(_promptBar),
                      ),
                    );
                    await TodoProvider.deleteTodo(index);
                    setState(
                      () {
                        BlocProvider.of<GroupsBloc>(context)
                            .add(DeleteGroups(group));
                        onGroupDeleted();
                      },
                    );
                  },
                  // 左滑容器
                  background: Container(
                    color: Colors.red,
                    child: ListTile(
                      trailing: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // 右滑容器
                  secondaryBackground: Container(
                    color: Colors.red,
                    child: ListTile(
                      trailing: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: groups.length,
          );
        }
        return Text("没有分类");
      }),
    );
  }
}