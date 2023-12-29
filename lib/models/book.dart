class Book {
  int? id;
  String title;
  String author;
  double priceRent;
  String bookCategory;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.priceRent,
    required this.bookCategory,
  });
}
