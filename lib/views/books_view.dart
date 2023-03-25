import 'package:flutter/material.dart';
import 'package:library_demo/views/add_book_view.dart';
import 'package:library_demo/views/book_model.dart';
import 'package:library_demo/views/update_book_view.dart';
import 'package:provider/provider.dart';
import 'books_view_model.dart';

class BooksView extends StatefulWidget {
  const BooksView({Key? key}) : super(key: key);

  @override
  State<BooksView> createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BooksViewModel>(
      create: (_) => BooksViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(title: const Center(child: Text("Book List"))),
        body: Center(
            child: Column(
          children: [
            StreamBuilder<List<Book>>(
                stream: Provider.of<BooksViewModel>(context, listen: false)
                    .getBookList(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return const Text("bir hata oluştu");
                  } else if (!asyncSnapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    List<Book> bookList = asyncSnapshot.data!;
                    return Flexible(
                        child: ListView.builder(
                            itemCount: bookList.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.horizontal,
                                background: Container(
                                  color: Colors.redAccent,
                                  child: const Icon(Icons.delete,
                                      color: Colors.white),
                                ),
                                onDismissed: (_) async {
                                  await Provider.of<BooksViewModel>(context,
                                          listen: false)
                                      .deleteBook(bookList[index]);
                                },
                                child: Card(
                                  child: ListTile(
                                    trailing: IconButton(
                                      icon: const Icon(Icons.design_services),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateBookView(
                                                      book: bookList[index]),
                                            ));
                                      },
                                    ),
                                    title: Text(bookList[index].bookName!),
                                    subtitle: Text(bookList[index].authorName!),
                                  ),
                                ),
                              );
                            }));
                  }
                }),
          ],
        )),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddBookView(),
                  ));
            }),
      ),
    );
  }
}
