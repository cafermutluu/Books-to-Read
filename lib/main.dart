import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:library_demo/views/books_view.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>(
      create: (_) => FirebaseFirestore.instance.collection("Books").snapshots(),
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("beklenilmeyen bir hata oluştu"),);
              } else if (snapshot.hasData) {
                return const BooksView();
              } else {
                return const Center(child: CircularProgressIndicator(),);
              }
            },
          )
      ),
    );
  }
}


