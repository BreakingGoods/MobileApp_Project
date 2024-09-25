class Transaction {

  final String title;
  final double year;
  final String gentr;
  bool watched;

  Transaction({

    required this.title,
    required this.year,
    required this.gentr,
    this.watched = false,
   
  });
}