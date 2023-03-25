import 'package:flutter/material.dart';
import 'package:library_demo/services/calculator.dart';
import 'package:library_demo/views/book_model.dart';
import 'package:library_demo/views/update_book_view_model.dart';
import 'package:provider/provider.dart';

class UpdateBookView extends StatefulWidget {
  const UpdateBookView({Key? key, required this.book,}) : super(key: key);

  final Book book;

  @override
  State<UpdateBookView> createState() => _UpdateBookViewState();
}

class _UpdateBookViewState extends State<UpdateBookView> {
  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  TextEditingController bookNameController = TextEditingController();
  TextEditingController writerController = TextEditingController();
  TextEditingController publishYearController = TextEditingController();

  @override
  void dispose() {
    bookNameController.dispose();
    writerController.dispose();
    publishYearController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bookNameController.text = widget.book.bookName!;
    writerController.text = widget.book.authorName!;
    publishYearController.text = Calculator.dateTimetoString(
        Calculator.dateTimefromTimeStamp(widget.book.publishDate!));

    return ChangeNotifierProvider<UpdateBookViewModel>(
      create: (_) => UpdateBookViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Update Book"),
        ),
        body: Container(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Enter a book name", icon: Icon(Icons.book)),
                    controller: bookNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Book name cannot be empty!";
                      } else {
                        return null;
                      }
                    }),
                const Padding(padding: EdgeInsets.only(top: 4.0)),
                TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Enter the name of the writer",
                        icon: Icon(Icons.edit)),
                    controller: writerController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Writer name cannot be empty!";
                      } else {
                        return null;
                      }
                    }),
                const Padding(padding: EdgeInsets.only(top: 4.0)),
                TextFormField(
                    onTap: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(-1000),
                        lastDate: DateTime.now(),
                      );
                      publishYearController.text =
                          Calculator.dateTimetoString(selectedDate!);
                    },
                    decoration: const InputDecoration(
                        hintText: "Enter the publish year of the book",
                        icon: Icon(Icons.calendar_month_outlined)),
                    controller: publishYearController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Publish year cannot be empty!";
                      } else {
                        return null;
                      }
                    }),
                const Padding(padding: EdgeInsets.only(top: 4.0)),
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await context.read<UpdateBookViewModel>().updateBook(
                            bookName: bookNameController.text,
                            authorName: writerController.text,
                            publishDate: selectedDate ??
                          Calculator.dateTimefromTimeStamp(widget.book.publishDate!),
                          book: widget.book,
                        );

                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Update")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
