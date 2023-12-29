import 'package:flutter/material.dart';
import 'package:gestalt_systec/database/database_helper.dart';
import 'package:gestalt_systec/models/book.dart';
import 'package:intl/intl.dart';

class BookList extends StatefulWidget {
  const BookList({super.key});

  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  bool showAllBooks = true;
  double? minPrice;
  double? maxPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Book Rental App'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: showAllBooks ? null : Colors.deepPurple,
            ),
            onPressed: () {
              setState(() {
                showAllBooks = !showAllBooks;
              });
            },
          ),
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color: (minPrice != null || maxPrice != null)
                  ? Colors.deepPurple
                  : null,
            ),
            onPressed: () {
              setState(() {
                if (minPrice != null || maxPrice != null) {
                  minPrice = null;
                  maxPrice = null;
                } else {
                  minPrice = 2000;
                  maxPrice = 6000;
                }
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: DatabaseHelper.instance
            .getBooks(showAllBooks, minPrice: minPrice, maxPrice: maxPrice),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<Book> books = snapshot.data as List<Book>;

            if (books.isEmpty) {
              return const Center(
                child: Text('Books is Empty'),
              );
            }
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 3,
                  child: ListTile(
                    title: Text(books[index].title),
                    subtitle: Text(
                      'Author: ${books[index].author}\nCategory: ${books[index].bookCategory}\nPrice: ${formatCurrency(books[index].priceRent)}',
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

String formatCurrency(double amount) {
  final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp');
  return formatCurrency.format(amount);
}
