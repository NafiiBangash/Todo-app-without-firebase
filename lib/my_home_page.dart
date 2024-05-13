// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/widgets/todo_item.dart';
import 'models/todo_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TodoModel> _ToDoList = TodoModel.todoList;
  final _searchController = TextEditingController();
  final _addToDoText = TextEditingController();
  List<TodoModel> _foundToDo = [];
  @override
  void initState() {
    _foundToDo = _ToDoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0.0,
        title:const  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu),
            CircleAvatar(
              backgroundImage: AssetImage('assets/ian-dooley-d1UPkiFd04A-unsplash.jpg'),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
          top: 30.0,
        ),
        child: Column(
          children: [
            buildSearchBar(),
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'ToDo List',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  for (TodoModel todo in _foundToDo.reversed)
                    TodoItem(
                      todo: todo,
                      onTap: () {
                        setState(() {
                          todo.isDone = !todo.isDone!;
                        });
                      },
                      onDelete: _onDeleteToDoItem,
                      handleTodoChange: _handleToDoChange,
                    ),
                  SizedBox(
                    height: screenHeight * 0.07,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: screenWidth,
        child: Row(
          children: [
            Expanded(
                child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: TextFormField(
                controller: _addToDoText,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
                  border: InputBorder.none,
                  hintText: 'Add Todo..',
                ),
              ),
            )),
            GestureDetector(
              onTap: () {
                _addToDoItem(_addToDoText.text);
                _addToDoText.clear();
              },
              child: Container(
                height: screenHeight * 0.06,
                width: screenWidth * 0.06,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleToDoChange(TodoModel todo) {
    setState(() {
      todo.isDone = !todo.isDone!;
    });
  }

  void _onDeleteToDoItem(String id) {
    setState(() {
      _ToDoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String title) {
    setState(() {
      _ToDoList.add(TodoModel(
          title: title, id: DateTime.now().millisecondsSinceEpoch.toString()));
    });
  }

  void _filterToDo(String enteredKeyword)
  {
    List<TodoModel> result = [];
    if(enteredKeyword.isEmpty)
      {
        result = _ToDoList;
      }else{
      result = _ToDoList.where((item) => item.title!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      _foundToDo = result;
    });
  }



  Widget buildSearchBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: _searchController,
        onChanged: (value)=> _filterToDo(value),
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search..',
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
