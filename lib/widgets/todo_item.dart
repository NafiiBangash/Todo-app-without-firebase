import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onTap;
  final handleTodoChange;
  final onDelete;
   const TodoItem({Key? key,required this.todo,required this.onTap,
     required this.onDelete,required this.handleTodoChange,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0)
      ),
      child: ListTile(
        onTap: ()=> handleTodoChange(todo),
        leading: Icon(todo.isDone!? Icons.check_box:Icons.check_box_outline_blank),
        title: Text(todo.title.toString(),style: TextStyle(
          decoration: todo.isDone!? TextDecoration.lineThrough : null
        ),),
        trailing: InkWell(
          onTap: ()=> onDelete(todo.id),
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(4.0)
            ),
            child: const Center(
              child: Icon(Icons.delete,color: Colors.white,size: 25.0,),
            ),
          ),
        )
      ),
    );
  }
}
