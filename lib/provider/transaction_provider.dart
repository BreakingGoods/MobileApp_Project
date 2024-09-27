import 'package:account/database/transaction_db.dart';
import 'package:flutter/foundation.dart';
import 'package:account/models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [
    
  ];

  List<Transaction> getTransaction() {
    return transactions;
  }
  void initData()async{
    var db=TransactionDB(dbName: ("transaction.db"));
    transactions=await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transaction transaction) async{
    var db = await TransactionDB(dbName: 'transactions.db');
    var keyID = await db.insertDatabase(transaction);
    this.transactions = await db.loadAllData();
    notifyListeners();
  }


  void toggleWatched(int index) {
    transactions[index].watched = !transactions[index].watched;
    notifyListeners();
  }

  void updateTransaction(int index, Transaction updateTransaction){
    transactions[index] = updateTransaction;
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

