import 'package:account/database/transaction_db.dart';
import 'package:flutter/foundation.dart';
import 'package:account/models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [];

  List<Transaction> getTransaction() {
    return transactions;
  }

  void initData() async {
    var db = TransactionDB(dbName: 'transactions.db');
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transaction transaction) async {
    var db = TransactionDB(dbName: 'transactions.db');
    await db.insertDatabase(transaction);

    transactions.add(transaction);
    notifyListeners();
  }

  void toggleWatched(int index) async {
    var db = TransactionDB(dbName: 'transactions.db');

    transactions[index].watched = !transactions[index].watched;

    await db.updateDatabase(transactions[index]);
    notifyListeners();
  }

  void updateTransaction(int index, Transaction updatedTransaction) async {
    var db = TransactionDB(dbName: 'transactions.db');

    await db.updateDatabase(updatedTransaction);

    transactions[index] = updatedTransaction;
    notifyListeners();
  }

  void deleteTransaction(int index) async {
    var db = TransactionDB(dbName: 'transactions.db'); 
    var transactionToDelete = transactions[index];

    if (transactionToDelete.id != null) {
      await db.deleteTransaction(transactionToDelete.id!);
    }

    transactions.removeAt(index);
    notifyListeners();
  }
}
