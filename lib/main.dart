import 'dart:async';

import 'package:flutter_todo/database/group_provider.dart';
import 'package:flutter_todo/database/todo_provider.dart';
import 'package:flutter_todo/ui/pages/group_page.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/group_bloc.dart';
import 'package:flutter_todo/blocs/group_event.dart';
import 'package:flutter_todo/blocs/group_state.dart';
import 'package:flutter_todo/blocs/todos_bloc.dart';
import 'package:flutter_todo/blocs/todos_event.dart';
import 'package:flutter_todo/models/group.dart';
import 'package:flutter_todo/ui/pages/new_group.dart';
import 'package:flutter_todo/ui/pages/todo_list.dart';
import 'package:flutter_todo/ui/widgets/bottom_sheet.dart';

// void main() {
//   runApp(MaterialApp(
//     title: 'ToDo',
//     theme: ThemeData(
//       primaryColor: Colors.blue,
//     ),
//     home: TodoApp(),
//   ));
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  run();
}

void run() async {
  var db = await initDatabase();
  TodoProvider.db = db;
  GroupProvider.db = db;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<GroupsBloc>(
          create: (context) {
            return GroupsBloc()..add(LoadGroups());
          },
        ),
        BlocProvider<TodosBloc>(create: (context) {
          return TodosBloc(BlocProvider.of<GroupsBloc>(context));
        }),
      ],
      child: MaterialApp(
        title: 'ToDo',
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        routes: {
          "/": (BuildContext context) => TodoApp(),
          "/createGroup": (BuildContext context) => NewGroup(),
        },
        initialRoute: "/",
      ),
    ),
  );
}

Future<Database> initDatabase() async {
  return await openDatabase(
    join(await getDatabasesPath(), 'todo_database.db'),
    onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE todos(id INTEGER PRIMARY KEY, content TEXT, isFinished VARCHAR(255) NOT NULL, createdAt INTEGER)",
      );
      await db.execute(
        "CREATE TABLE groups(id INTEGER PRIMARY KEY, name TEXT, todos TEXT)",
      );
    },
    version: 2,
  );
}

// Widget createGroup(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text(
//         '新建分类',
//         style: TextStyle(fontSize: 20.0, color: Colors.white),
//       ),
//       elevation: 0.0,
//     ),
//     body: TextField(
//       decoration: InputDecoration(
//         hintText: '新建分类',
//         contentPadding: EdgeInsets.all(10.0),
//       ),
//       onSubmitted: (text) async {
//         if (text.length == 0) {
//           Navigator.of(context).pop();
//         } else {
//           var newGroup = Group(
//             id: null,
//             name: text,
//           );
//           await GroupProvider.insertGroup(newGroup);
//           Navigator.of(context).pop();
//           BlocProvider.of<GroupsBloc>(context).add(AddGroup(newGroup));
//         }
//       },
//     ),
//   );
// }

class TodoApp extends StatelessWidget {
  TodoApp({this.group, this.onGroupDeleted});

  final Group group;

  final Function() onGroupDeleted;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '待办事项',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.art_track),
            tooltip: '分类列表',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GroupPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.playlist_add),
            tooltip: '新建分类',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewGroup()),
              );
            },
          ),
        ],
      ),
      // drawer: GroupPage(),
      body: TodoList(),
    );
  }

  // Widget buildDrawer() {
  //   return Drawer(
  //     child: BlocBuilder<GroupsBloc, GroupsState>(builder: (context, state) {
  //       if (state is GroupsLoaded) {
  //         final groups = state.groups;
  //         return ListView.builder(
  //           itemBuilder: (context, index) {
  //             final group = groups[index];
  //             return Card(
  //               child: Dismissible(
  //                 key: Key('key${[index]}'),
  //                 child: ListTile(
  //                   title: GestureDetector(
  //                     child: Text(
  //                       group.name,
  //                     ),
  //                   ),
  //                   onTap: () {
  //                     BlocProvider.of<GroupsBloc>(context).add(LoadGroups());
  //                     Navigator.pop(context);
  //                   },
  //                 ),
  //                 onDismissed: (direction) async {
  //                   // 定义提示
  //                   var _promptBar;
  //                   if (direction == DismissDirection.endToStart) {
  //                     _promptBar = '删除了${[index]}';
  //                   } else if (direction == DismissDirection.startToEnd) {
  //                     _promptBar = '删除了${[index]}';
  //                   }
  //                   Scaffold.of(context).showSnackBar(
  //                     SnackBar(
  //                       // 弹出提示语句
  //                       content: Text(_promptBar),
  //                     ),
  //                   );
  //                   await TodoProvider.deleteTodo(index);
  //                   setState(
  //                     () {
  //                       BlocProvider.of<GroupsBloc>(context)
  //                           .add(DeleteGroups(group));
  //                       onGroupDeleted();
  //                     },
  //                   );
  //                 },
  //                 // 左滑容器
  //                 background: Container(
  //                   color: Colors.red,
  //                   child: ListTile(
  //                     trailing: Icon(
  //                       Icons.delete,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //                 // 右滑容器
  //                 secondaryBackground: Container(
  //                   color: Colors.red,
  //                   child: ListTile(
  //                     trailing: Icon(
  //                       Icons.delete,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           },
  //           itemCount: groups.length,
  //         );
  //       }
  //       return Text("没有分类");
  //     }),
  //   );
  // }

  void setState(Null Function() param0) {}
}

// import 'package:flutter/material.dart';
// import 'package:flutter_todo/ui/pages/home_page.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ToDo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         accentColor: Colors.lightBlue,
//         brightness: Brightness.light,
//       ),
//       initialRoute: "/",
//       home: HomePage(),
//     );
//   }
// }
