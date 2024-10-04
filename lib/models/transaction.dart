class Transaction {
  final String title;
  final double year;
  final String genre;
  bool watched;
  int? id; 

  Transaction({
    required this.title,
    required this.year,
    required this.genre,
    this.watched = false,
    this.id, 
  });
}
