import 'package:flutter/foundation.dart';
import 'package:account/models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [
    Transaction(title: 'หนังสือ', year: 300, date: DateTime.now(),genre:''),
    Transaction(title: 'เสื้อ', year: 500, date: DateTime.now(),genre: ''),
    Transaction(title: 'รองเท้า', year: 1000, date: DateTime.now(),genre: ''),
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
}
