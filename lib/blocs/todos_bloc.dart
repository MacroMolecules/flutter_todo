import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_todo/blocs/group_bloc.dart';
import 'package:flutter_todo/blocs/group_state.dart';
// import 'package:meta/meta.dart';
import 'package:flutter_todo/blocs/todos_event.dart';
import 'package:flutter_todo/blocs/todos_state.dart';
import 'package:flutter_todo/models/todo.dart';
// import 'package:flutter_todo/models/todo.dart';
// import 'package:todos_repository_simple/todos_repository_simple.dart';

// class TodosBloc extends Bloc<TodosEvent, TodosState> {
//   final GroupsBloc groupsBloc;
//   StreamSubscription groupsSubscription;

//   TodosBloc(this.groupsBloc);

// //   TodosBloc({@required this.todosRepository});

//   @override
//   TodosState get initialState => TodosLoading();

//   @override
//   Stream<TodosState> mapEventToState(TodosEvent event) async* {
//     if (event is LoadTodos) {
//       yield* _mapLoadTodosToState(event);
//     } else if (event is AddTodo) {
//       yield* _mapAddTodoToState(event);
//     } else if (event is UpdateTodo) {
//       yield* _mapUpdateTodoToState(event);
//     } else if (event is DeleteTodo) {
//       yield* _mapDeleteTodoToState(event);
//     }
//     // else if (event is ToggleAll) {
//     //   yield* _mapToggleAllToState();
//     // } else if (event is ClearCompleted) {
//     //   yield* _mapClearCompletedToState();
//     // }
//   }

//   Stream<TodosState> _mapLoadTodosToState(LoadTodos event) async* {
//     if (event.groupID == 1) {
//       yield TodosLoaded();
//     } else {
//       yield TodosNotLoaded();
//     }
//   }

//   Stream<TodosState> _mapAddTodoToState(AddTodo event) async* {
//     if (state is TodosLoaded) {
//       final List<Todo> updatedTodos = List.from((state as TodosLoaded).todos)
//         ..add(event.todo);
//       yield TodosLoaded(updatedTodos);
//       // _saveTodos(updatedTodos);
//     }
//   }

//   Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
//     if (state is TodosLoaded) {
//       final List<Todo> updatedTodos = (state as TodosLoaded).todos.map((todo) {
//         return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
//       }).toList();
//       yield TodosLoaded(updatedTodos);
//       // _saveTodos(updatedTodos);
//     }
//   }

//   Stream<TodosState> _mapDeleteTodoToState(DeleteTodo event) async* {
//     if (state is TodosLoaded) {
//       final updatedTodos = (state as TodosLoaded)
//           .todos
//           .where((todo) => todo.id != event.todo.id)
//           .toList();
//       yield TodosLoaded(updatedTodos);
//       // _saveTodos(updatedTodos);
//     }
//   }

// //   Stream<TodosState> _mapToggleAllToState() async* {
// //     if (state is TodosLoaded) {
// //       final allComplete =
// //           (state as TodosLoaded).todos.every((todo) => todo.complete);
// //       final List<Todo> updatedTodos = (state as TodosLoaded)
// //           .todos
// //           .map((todo) => todo.copyWith(complete: !allComplete))
// //           .toList();
// //       yield TodosLoaded(updatedTodos);
// //       _saveTodos(updatedTodos);
// //     }
// //   }

// //   Stream<TodosState> _mapClearCompletedToState() async* {
// //     if (state is TodosLoaded) {
// //       final List<Todo> updatedTodos =
// //           (state as TodosLoaded).todos.where((todo) => !todo.complete).toList();
// //       yield TodosLoaded(updatedTodos);
// //       _saveTodos(updatedTodos);
// //     }
// //   }

//   @override
//   Future<void> close() {
//     groupsSubscription.cancel();
//     return super.close();
//   }
// }

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final GroupsBloc groupBloc;
  StreamSubscription groupsSubscription;

  TodosBloc(this.groupBloc) {
    groupsSubscription = groupBloc.listen((state) {
      if (state is GroupsLoaded) {
        if (state.groups.length == 0) {
          return;
        }
        final groudID = state.groups[0].id;
        add(LoadTodos(groudID));
      }
    });
  }

  @override
  TodosState get initialState => TodosNotLoaded();

  // 私有mapEventToState处理程序中产生状态
  @override
  Stream<TodosState> mapEventToState(TodosEvent event) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodos(event);
    } else if (event is AddTodo) {
      yield* _mapAddTodo(event);
    } else if (event is UpdateTodo) {
      yield* _mapUpdateTodoToState(event);
    } else if (event is DeleteTodo) {
      yield* _mapDeleteTodo(event);
    }
  }

  // 告诉Bloc需要从中加载待办事项TodosRepository
  Stream<TodosState> _mapLoadTodos(LoadTodos event) async* {
    if (event.groupID == 1) {
      yield TodosLoaded();
    } else {
      yield TodosLoaded();
    }
  }

  // 告诉Bloc需要将新的待办事项添加到待办事项列表中
  Stream<TodosState> _mapAddTodo(AddTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos = List.from((state as TodosLoaded).todos)
        ..add(event.todo);
      yield TodosLoaded(updatedTodos);
    }
  }

  // 告诉Bloc它需要更新现有的待办事项
  Stream<TodosState> _mapUpdateTodoToState(UpdateTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos = (state as TodosLoaded).todos.map((todo) {
        return todo.id == event.updatedTodo.id ? event.updatedTodo : todo;
      }).toList();
      yield TodosLoaded(updatedTodos);
      // _saveTodos(updatedTodos);
    }
  }

  // 告诉Bloc它需要删除现有的待办事项
  Stream<TodosState> _mapDeleteTodo(DeleteTodo event) async* {
    if (state is TodosLoaded) {
      final List<Todo> updatedTodos = List.from((state as TodosLoaded).todos)
        ..remove(event.todo);
      yield TodosLoaded(updatedTodos);
    }
  }

  // 异步任务在将来执行时产生的结果
  @override
  Future<void> close() {
    groupsSubscription.cancel();
    return super.close();
  }
}
