import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import '../controller/controller.dart';
import 'package:todo_app/repository/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //debendency injection
    var todoController = TodoController(TodoRepository());

    //test
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[100],
        title: Center(child: const Text('Rest Api')),
      ),
      body: FutureBuilder(
        future: todoController.feachTodoList(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(child: Text('error'));
          }
          //List<Todo> todo = snapshot.data as List<Todo>;
          //take safeArea to extract method
          return buildBodyContent(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Todo todo = Todo(userId: 3, title: 'simple post', completed: false);
          todoController.postTodo(todo);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContent(
      AsyncSnapshot<List<dynamic>> snapshot, TodoController todoController) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            // kant error lma kant el snapshot mn 8er  AsyncSnapshot<List> snapshot
            var todo = snapshot.data?[index];
            return Container(
              height: 100.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text('${todo?.id}')),
                  Expanded(flex: 3, child: Text('${todo?.title}')),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              //make controller method befor calling
                              todoController
                                  .updatePatchCompleted(todo!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text(value)));
                              });
                            },
                            child: buildCallContainer(
                                'patch', const Color(0xFFFFE0B2)),
                          ),
                          InkWell(
                            onTap: () {
                              todoController.updatePutCompleted(todo!);
                            },
                            child: buildCallContainer(
                                'Put', const Color(0xFFE1BEE7)),
                          ),
                          InkWell(
                            onTap: () {
                              todoController.deleteTodo(todo!).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text(value)));
                              });
                            },
                            child: buildCallContainer(
                                'del', const Color(0xFFFFCDD2)),
                          ),
                        ],
                      )),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 0.5,
              height: 0.5,
            );
          },
          itemCount: snapshot.data?.length ?? 0),
    );
  }

// container in row
  Container buildCallContainer(String title, Color color) {
    return Container(
      height: 40.0,
      width: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child: Text(title)),
    );
  }
}
