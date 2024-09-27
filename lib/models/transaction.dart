class Transaction {
  final String title;
  final double year;
  final String genre;
  bool watched;
  int? id; // Add this field to store the database key

  Transaction({
    required this.title,
    required this.year,
    required this.genre,
    this.watched = false,
    this.id, // Add id to constructor
  });
}
