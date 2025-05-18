class ListTodo {
  int? id;
  String title;
  
  ListTodo({
    required this.title,
    required this.id,
  });
  
  factory ListTodo.fromJson(Map<String, dynamic> json) {
    return ListTodo(title: json['title'], id: json['id']);
  }
  
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'id': id,
    };
  }
}