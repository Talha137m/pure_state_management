// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlbumModelClass {
  int userId;
  int id;
  String title;
  AlbumModelClass({
    required this.userId,
    required this.id,
    required this.title,
  });

  AlbumModelClass copyWith({
    int? userId,
    int? id,
    String? title,
  }) {
    return AlbumModelClass(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
    };
  }

  factory AlbumModelClass.fromMap(Map<String, dynamic> map) {
    return AlbumModelClass(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlbumModelClass.fromJson(String source) =>
      AlbumModelClass.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AlbumModelClass(userId: $userId, id: $id, title: $title)';

  @override
  bool operator ==(covariant AlbumModelClass other) {
    if (identical(this, other)) return true;

    return other.userId == userId && other.id == id && other.title == title;
  }

  @override
  int get hashCode => userId.hashCode ^ id.hashCode ^ title.hashCode;
}
