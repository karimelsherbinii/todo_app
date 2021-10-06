// ma5zan elta8yeer
import '../models/todo_model.dart';

abstract class Repository {
  //get
  Future<List<Todo>> getTodoList();
  //patch
  Future<String> patchCompleted(Todo todo);
  //put
  Future<String> putCompleted(Todo todo);
  //delete
  Future<String> deletedCompleted(Todo todo); 
  //post
  Future<String> postCompleted(Todo todo);
}
