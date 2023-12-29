class Rent {
  int? id;
  int customerId;
  int bookId;
  String dateRent;
  String dateReturn;

  Rent({
    this.id,
    required this.customerId,
    required this.bookId,
    required this.dateRent,
    required this.dateReturn,
  });
}
