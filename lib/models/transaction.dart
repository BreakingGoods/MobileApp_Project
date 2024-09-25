class Transaction {
  // final String id;
  final String title;
  final double year;
  final String gentr;
  bool watched;

  Transaction({
    // required this.id,
    required this.title,
    required this.year,
    required this.gentr,
    this.watched = false,
   
  });
}