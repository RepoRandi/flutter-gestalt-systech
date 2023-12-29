class Customer {
  int? id;
  String name;
  String identityCardNumber;
  String address;
  int rentalsCount;
  List<String> bookTitles;

  Customer({
    this.id,
    required this.name,
    required this.identityCardNumber,
    required this.address,
    required this.rentalsCount,
    required this.bookTitles,
  });
}
