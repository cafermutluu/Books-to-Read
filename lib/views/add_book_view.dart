import 'package:flutter/material.dart';
import 'package:library_demo/services/calculator.dart';
import 'package:library_demo/views/add_book_view_model.dart';
import 'package:provider/provider.dart';

class AddBookView extends StatefulWidget {
  const AddBookView({Key? key}) : super(key: key);

  @override
  State<AddBookView> createState() => _AddBookViewState();
}

class _AddBookViewState extends State<AddBookView> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;

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
    return ChangeNotifierProvider<AddBookViewModel>(
      create: (_) => AddBookViewModel(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Add Book"),
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
                      _selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(-1000),
                        lastDate: DateTime.now(),
                      );
                      publishYearController.text =
                          Calculator.dateTimetoString(_selectedDate!);
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
                        await context.read<AddBookViewModel>().addNewBook(
                            bookName: bookNameController.text,
                            authorName: writerController.text,
                            publishDate: _selectedDate);

                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Save")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
