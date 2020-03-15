import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/blocs/group_bloc.dart';
import 'package:flutter_todo/blocs/group_event.dart';
import 'package:flutter_todo/database/group_provider.dart';
import 'package:flutter_todo/models/group.dart';

class NewGroup extends StatefulWidget {
  @override
  _NewGroupState createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '新建分类',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        elevation: 0.0,
      ),
      body: TextField(
        decoration: InputDecoration(
          hintText: '新建分类',
          contentPadding: EdgeInsets.all(10.0),
        ),
        onSubmitted: (text) async {
          if (text.length == 0) {
            Navigator.of(context).pop();
          } else {
            var newGroup = Group(
              id: null,
              name: text,
            );
            await GroupProvider.insertGroup(newGroup);
            Navigator.of(context).pop();
            BlocProvider.of<GroupsBloc>(context).add(AddGroup(newGroup));
          }
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_todo/blocs/group_bloc.dart';
// import 'package:flutter_todo/blocs/group_event.dart';
// import 'package:flutter_todo/models/group.dart';

// class NewGroup extends StatefulWidget {
//   NewGroup({this.group, this.onGroupDeleted});

//   final Group group;

//   final Function() onGroupDeleted;

//   @override
//   _NewGroupState createState() => _NewGroupState();
// }

// class _NewGroupState extends State<NewGroup> {
//   final TextEditingController _textFieldController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {

//     // List<Group> groups;
//     return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//       Padding(
//         padding: EdgeInsets.symmetric(
//           vertical: 8.0,
//           horizontal: 16.0,
//         ),
//         child: TextField(
//           autofocus: true,
//           keyboardType: TextInputType.text,
//           decoration: InputDecoration(
//             hintText: "新建分类",
//             hintStyle: TextStyle(
//               color: Colors.grey,
//             ),
//             focusedBorder: InputBorder.none,
//             errorBorder: InputBorder.none,
//           ),
//           onSubmitted: (String content) {
//               if (content.isEmpty) {
//                 return;
//               }
//               Group newGroup = Group();
//               BlocProvider.of<GroupsBloc>(context).add(AddGroup(newGroup));
//               _textFieldController.clear();
//             },
//           // onSubmitted: (String name) {
//           //   if (name.isEmpty) {
//           //     return;
//           //   }
//           //   setState(() {
//           //     widget.group.name = name;
//           //   });
//           // },
//         ),
//       ),
//       // Padding(
//       //   padding: EdgeInsets.only(
//       //     top: 8.0,
//       //     bottom: 8.0,
//       //     left: 16.0,
//       //   ),
//       //   child: Row(
//       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //     children: <Widget>[
//       //       Icon(
//       //         Icons.bookmark,
//       //         color: Colors.white,
//       //       ),
//       //       ButtonBar(
//       //         children: <Widget>[
//       //           FlatButton(
//       //             child: Text("取消"),
//       //             onPressed: () {
//       //               Navigator.pop(context);
//       //               _taskFieldController.clear();
//       //             },
//       //           ),
//       //           FlatButton(
//       //             child: Text(
//       //               "确认",
//       //               style: TextStyle(
//       //                 color: Theme.of(context).primaryColor,
//       //               ),
//       //             ),
//       //             onPressed: () {
//       //               String name;
//       //               if (name.isEmpty) {
//       //                 return;
//       //               }
//       //               setState(() {
//       //                 widget.group.name = name;
//       //               });
//       //             },
//       //           ),
//       //         ],
//       //       )
//       //     ],
//       //   ),
//       // ),
//     ]);
//   }
// }
