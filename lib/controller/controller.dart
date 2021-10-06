import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../repository/repository.dart';

class TodoController {
  final Repository _repository;
  TodoController(this._repository);

  //get
  Future<List<Todo>> feachTodoList() async {
    return _repository.getTodoList();
  }

// patch
  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }

  //put
  Future<String> updatePutCompleted(Todo todo) async {
    return _repository.putCompleted(todo);
  }

  //delete
  Future<String> deleteTodo(Todo todo) async {
    return _repository.deletedCompleted(todo);
  }

  // post
  Future<String> postTodo(Todo todo) async {
    return _repository.postCompleted(todo);
  }
}
