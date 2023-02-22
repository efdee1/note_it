class Note {
  String? title;
  String? description;
  String? id;
  DateTime? createdAt;

  Note(this.title, this.description, this.id);

  Note.fromMap(Map<String, dynamic> data, String id)
      : title = data['title'],
        description = data['description'],
        createdAt = data['createdAt'].toDate();

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "createdAt": createdAt,
    };
  }

  // static Note fromJson(Map<String, dynamic> json) =>
  //     Note(title: json['title'], description: ['description'], id: ['id']);
}

// class Note {
//   String? id;
//   String? title;
//   String? description;
//
//   Note({this.id, this.title, this.description});
//
//   factory Note.fromSnapshot(Map<String, dynamic> data, String id) {
//     //var snapshot;
//     return Note(
//       id: data['id'],
//       title: data['title'],
//       description: data['description'],
//     );
//   }
// }
