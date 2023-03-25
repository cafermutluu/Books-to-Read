import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  final String? id;
  final String? bookName;
  final String? authorName;
  final Timestamp? publishDate;

  Book({this.id, this.bookName, this.authorName, this.publishDate});

  /// Objeyi Map'e çevirme fonksiyonu

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": bookName,
        "writter": authorName,
        "year": publishDate,
      };

  /// Map'i objeye çevirme fonksiyonu

  factory Book.fromMap(Map map) => Book(
        id: map["id"],
        bookName: map["name"],
        publishDate: map["year"],
        authorName: map["writter"],
      );
}
