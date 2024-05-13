class TodoModel{
  String? title;
  String? id;
  bool? isDone;
  TodoModel({
    required this.title,
    required this.id,
    this.isDone = false,
});
  static List<TodoModel> todoList = [
    TodoModel(title: 'Today is coding day', id: '1',isDone: true),
    TodoModel(title: 'Yesterday was friday', id: '2'),
    TodoModel(title: 'No smoking challenge is processing', id: '3'),
    TodoModel(title: 'Paper preparation is done', id: '4',isDone: true),
    TodoModel(title: 'Reading book is done', id: '5',isDone: true),
  ];
}