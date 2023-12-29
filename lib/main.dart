import 'package:flutter/material.dart';
import 'package:gestalt_systec/database/database_helper.dart';
import 'package:gestalt_systec/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.initDatabase();
  await _insertDummyData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Rental App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

Future<void> _insertDummyData() async {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  await databaseHelper.database.then((db) async {
    await db.transaction((txn) async {
      Batch batch = txn.batch();

      // batch.delete('Book');
      // batch.delete('Customer');
      // batch.delete('Rent');

      // Tambahkan data contoh ke tabel Book
      batch.insert('Book', {
        'title': 'Harry Potter and the Sorcerer\'s Stone',
        'author': 'J.K. Rowling',
        'price_rent': 4000,
        'book_category': 'NOVEL',
      });

      batch.insert('Book', {
        'title': 'The Hobbit',
        'author': 'J.R.R. Tolkien',
        'price_rent': 5000,
        'book_category': 'NOVEL',
      });

      batch.insert('Book', {
        'title': 'Manga Adventures',
        'author': 'Manga Artist',
        'price_rent': 5500,
        'book_category': 'MANGA',
      });

      batch.insert('Book', {
        'title': 'National Geographic - The Cosmos',
        'author': 'Various',
        'price_rent': 6000,
        'book_category': 'MAGAZINE',
      });

      batch.insert('Book', {
        'title': 'Dilan 1999',
        'author': 'Jamal',
        'price_rent': 8000,
        'book_category': 'NOVEL',
      });

      batch.insert('Book', {
        'title': 'Laskar Pelangi',
        'author': 'Nidji',
        'price_rent': 10000,
        'book_category': 'NOVEL',
      });

      batch.insert('Book', {
        'title': 'Tanah Airku',
        'author': 'Imam',
        'price_rent': 12000,
        'book_category': 'MAGAZINE',
      });

      batch.insert('Book', {
        'title': 'Otodriver',
        'author': 'Imam',
        'price_rent': 14000,
        'book_category': 'MAGAZINE',
      });

      batch.insert('Book', {
        'title': 'Wirosableng',
        'author': 'Jayus',
        'price_rent': 15000,
        'book_category': 'MANGA',
      });

      batch.insert('Book', {
        'title': 'Detective Conan',
        'author': 'Gosho Aoyama',
        'price_rent': 17000,
        'book_category': 'NOVEL',
      });

      batch.insert('Book', {
        'title': 'Boruto Ultimate',
        'author': 'Shonen',
        'price_rent': 20000,
        'book_category': 'MANGA',
      });

      batch.insert('Book', {
        'title': 'One Piece',
        'author': 'Eiichiro Oda',
        'price_rent': 25000,
        'book_category': 'MANGA',
      });

      batch.insert('Book', {
        'title': 'One-Punch Man',
        'author': 'Yūsuke Murata',
        'price_rent': 27000,
        'book_category': 'MANGA',
      });

      batch.insert('Book', {
        'title': 'Elite Global',
        'author': 'Yūsuke Murata',
        'price_rent': 30000,
        'book_category': 'MAGAZINE',
      });

      // Tambahkan data contoh ke tabel Customer
      batch.insert('Customer', {
        'name': 'Randi Maulana',
        'identity_card_number': '1234567890',
        'address': 'Malang - Jawa Timur',
      });

      batch.insert('Customer', {
        'name': 'Ananda Dwi',
        'identity_card_number': '0987654321',
        'address': 'Bandung - Jawa Barat',
      });

      // Tambahkan data contoh ke tabel Rent
      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 1,
        'date_rent': '2023-08-01',
        'date_return': '2023-08-03',
      });

      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 2,
        'date_rent': '2023-08-05',
        'date_return': '2023-08-08',
      });

      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 3,
        'date_rent': '2023-08-10',
        'date_return': '2023-08-13',
      });

      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 4,
        'date_rent': '2023-09-14',
        'date_return': '2023-09-17',
      });

      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 5,
        'date_rent': '2023-09-18',
        'date_return': '2023-09-21',
      });

      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 6,
        'date_rent': '2023-10-22',
        'date_return': '2023-10-25',
      });

      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 7,
        'date_rent': '2023-10-26',
        'date_return': '2023-10-29',
      });

      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 8,
        'date_rent': '2023-11-1',
        'date_return': '2023-11-3',
      });

      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 9,
        'date_rent': '2023-11-4',
        'date_return': '2023-11-7',
      });

      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 10,
        'date_rent': '2023-11-08',
        'date_return': '2023-11-11',
      });

      batch.insert('Rent', {
        'customer_id': 1,
        'book_id': 11,
        'date_rent': '2023-11-12',
        'date_return': '2023-11-15',
      });

      batch.insert('Rent', {
        'customer_id': 2,
        'book_id': 2,
        'date_rent': '2023-12-01',
        'date_return': '2023-12-10',
      });

      batch.insert('Rent', {
        'customer_id': 2,
        'book_id': 3,
        'date_rent': '2023-12-01',
        'date_return': '2023-12-10',
      });

      await batch.commit();
    });
  });
}
