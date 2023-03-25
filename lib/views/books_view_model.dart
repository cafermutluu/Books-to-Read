import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:library_demo/views/book_model.dart';
import 'package:library_demo/services/database.dart';

class BooksViewModel extends ChangeNotifier {
  /// Books view'in state bilgisini tutmak

  /// books view arayüzünün ihtiyacı olan metotları ve hesaplamaları yapmak

  /// gerekli servislerle konuşmak

  String collectionPath = "Books";
  final Database _database = Database();

  Stream<List<Book>> getBookList() {
    /// Stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>
    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getBooksListfromApi(collectionPath)
        .map((querySnaphot) => querySnaphot.docs);

    /// Stream<List<DocumentSnapshot>> --> Stream<List<Book>>
    Stream<List<Book>> streamListBook = streamListDocument.map(
        (listOfDocSnap) => listOfDocSnap
            .map((docSnap) => Book.fromMap(docSnap.data()as Map<String, dynamic>))
            .toList());
    return streamListBook;
  }

  Future<void> deleteBook(Book book) async {
    await _database.deleteDocumentfromApi(collectionPath, book.id!);
    print(book.id);
  }
}
