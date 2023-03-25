import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_demo/views/book_model.dart';

class Database {
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  /// Databaseden gelen veri akışını sağlamak

  Stream<QuerySnapshot> getBooksListfromApi(String collectionPath) {
    return _firebase.collection(collectionPath).snapshots();
  }

  /// Databasedeki verinin silinmesini sağlamak

  Future<void> deleteDocumentfromApi(String collectionPath, String id) async {
    await _firebase.collection(collectionPath).doc(id).delete();
  }

  /// Databasedeki verinin ekleme ve güncellenmesini sağlamak

  Future<void> setBookData(
      {String? collectionPath, Map<String, dynamic>? bookAsMap}) async {
    await _firebase
        .collection(collectionPath!)
        .doc(Book.fromMap(bookAsMap!).id)
        .set(bookAsMap);
  }
}
