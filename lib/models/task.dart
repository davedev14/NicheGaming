class Task {
  // ID do documento 
  String? id;
  // Nome da Tarefa
  String title;
  // Status 
  bool done;
  // Dono da terefa
  String userId;

  Task({
    this.id,
    required this.title,
    required this.userId,
    this.done = false
    });
    // converter para json
  Map<String, dynamic> toMap(){
    return{
      'title': title,
      'done': done,
      'userId': userId};
  }
  // Converte Json em um objeto
  factory Task.fromMap(
    Map<String, dynamic> map,
    String id,
  ){
    return Task(
      id: id,
      title: map['title'],
      done: map['done'],
      userId: map['userId']
    );
  }
}