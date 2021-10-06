import '../models/todo_model.dart';
import '../repository/repository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// take implement from repository abstraact class
class TodoRepository implements Repository {
  //use http
  String dataUrl = 'https://jsonplaceholder.typicode.com';
  @override
  Future<String> deletedCompleted(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    var result = 'false';
    await http.delete(url).then((value) {
      print(value.body);
      return result = 'true';
    });
    return result;
  }

  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];
    var url = Uri.parse('$dataUrl/todos');
    var response = await http.get(url);
    // ignore: avoid_print
    print('status code is: ${response.statusCode}');
    var body = jsonDecode(response.body);
    // convert
    // for (var i in body) {
    //   todoList.add(Todo.fromJson(i));
    // }
    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }

// patch example
// modify pass vars only from top method
  @override
  Future<String> patchCompleted(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    //call back data
    String resData = '';
    //bool ? => to string
    await http.patch(
      url,
      body: {'completed': (!todo.completed!).toString()},
      headers: {'Authorization': 'your_toekn'},
    ).then((response) {
      //homeScreen -> Data
      Map<String, dynamic> result = json.decode(response.body);
      // print("result is : $result");
      return resData = result['completed'];
      //make call
    });
    return resData;
  }

  @override
  Future<String> postCompleted(Todo todo) async {
    print('${todo.toJson()}');
    var url = Uri.parse('$dataUrl/todos');
    var result = '';
    var response = await http.post(url, body: todo.toJson());
    // fake server => get return type != post type
    //change tojson method for that to string()
    print(response.statusCode);
    print(response.body);
    return 'true';
  }

  @override
  Future<String> putCompleted(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    String resData = '';
    await http.put(
      url,
      body: {
        'completed': (!todo.completed!).toString(),
      },
      headers: {'Authorization': 'your_toekn'},
    ).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      print(result);
      return resData = result['completed'];
    });
    return resData;
  }
}
