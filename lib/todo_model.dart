class Todo {
  int? id;
  String? title;
  String? body;

  Todo({this.body, this.id, this.title});

  Map<String, dynamic> toMap() {
    return {"id": id, "title": title, "body": body};
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    title = map["title"];
    body = map["body"];
  }
}
