import 'package:gestalt_systec/models/book.dart';
import 'package:gestalt_systec/models/customer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

export 'package:sqflite/sqflite.dart';
export 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'rental_database.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Book (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            author TEXT,
            price_rent REAL CHECK (price_rent > 0),
            book_category TEXT CHECK (book_category IN ('MANGA', 'NOVEL', 'MAGAZINE'))
          )
        ''');

        await db.execute('''
          CREATE TABLE Customer (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            identity_card_number TEXT NOT NULL,
            address TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE Rent (
            id INTEGER PRIMARY KEY,
            customer_id INTEGER,
            book_id INTEGER,
            date_rent TEXT NOT NULL,
            date_return TEXT CHECK (date_return > date_rent),
            FOREIGN KEY (customer_id) REFERENCES Customer (id),
            FOREIGN KEY (book_id) REFERENCES Book (id)
          )
        ''');
      },
    );
  }

  Future<List<Book>> getBooks(bool showAllBooks,
      {double? minPrice, double? maxPrice}) async {
    final Database db = await database;
    String query;

    if (showAllBooks) {
      query = 'SELECT * FROM Book WHERE 1 = 1';
    } else {
      query = '''
      SELECT * FROM Book
      WHERE id NOT IN (SELECT book_id FROM Rent)
    ''';
    }

    if (minPrice != null) {
      query += ' AND price_rent >= $minPrice';
    }

    if (maxPrice != null) {
      query += ' AND price_rent < $maxPrice';
    }

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);
    return List.generate(maps.length, (index) {
      return Book(
        id: maps[index]['id'],
        title: maps[index]['title'],
        author: maps[index]['author'],
        priceRent: maps[index]['price_rent'].toDouble(),
        bookCategory: maps[index]['book_category'],
      );
    });
  }

  Future<String?> getBookTitleById(int bookId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'Book',
      where: 'id = ?',
      whereArgs: [bookId],
    );

    if (maps.isNotEmpty) {
      return maps.first['title'] as String?;
    }

    return null;
  }

  Future<List<Customer>> getCustomersWithMoreThan10Rentals() async {
    final Database db = await database;

    final List<Map<String, dynamic>> customerMaps = await db.rawQuery('''
    SELECT c.id, c.name, c.identity_card_number, c.address, COUNT(r.id) AS rental_count
    FROM Customer c
    LEFT JOIN Rent r ON c.id = r.customer_id
    GROUP BY c.id
    HAVING rental_count > 10
  ''');

    final List<Customer> customers = [];

    for (var customerMap in customerMaps) {
      final List<Map<String, dynamic>> rentalsMaps = await db.query('Rent',
          where: 'customer_id = ?', whereArgs: [customerMap['id']]);

      final List<String> bookTitles = [];

      for (var rentMap in rentalsMaps) {
        final String? bookTitle =
            await getBookTitleById(rentMap['book_id'] as int);
        bookTitles.add(bookTitle!);
      }

      customers.add(
        Customer(
          id: customerMap['id'],
          name: customerMap['name'],
          identityCardNumber: customerMap['identity_card_number'],
          address: customerMap['address'],
          rentalsCount: customerMap['rental_count'],
          bookTitles: bookTitles,
        ),
      );
    }

    return customers;
  }
}
