import 'package:flutter/foundation.dart';
import 'package:account/models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [
    Transaction(title: 'Movie 1', year: 2024, gentr: 'Horror'),
    Transaction(title: 'Movie 2', year: 2024, gentr: 'Comedy'),
    Transaction(title: 'Movie 3', year: 2024, gentr: 'Horror'),
  ];

  List<Transaction> getTransaction() {
    return transactions;
  }

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    notifyListeners();
  }

  void deleteTransaction(int index) {
    transactions.removeAt(index);
    notifyListeners();
  }

  void toggleWatched(int index) {
    transactions[index].watched = !transactions[index].watched;
    notifyListeners();
  }

}

