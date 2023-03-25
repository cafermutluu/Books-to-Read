import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:library_demo/services/calculator.dart';
import 'package:library_demo/services/database.dart';
import 'package:library_demo/views/book_model.dart';

class UpdateBookViewModel extends ChangeNotifier {
  final Database _database = Database();
  String collectionPath = "Books";

  Future<void> updateBook(
      {String? bookName, String? authorName, DateTime? publishDate, Book? book}) async {
    Book newBook = Book(
      id: book!.id,
      bookName: bookName,
      authorName: authorName,
      publishDate: Calculator.dateTimetoTimeStamp(publishDate!),
    );

    /// Aldığı kitap bilgisini database sevisi üzerinden firestore'a yazacak

    await _database.setBookData(collectionPath: collectionPath, bookAsMap: newBook.toMap());
  }
}
