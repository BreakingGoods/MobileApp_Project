import 'dart:io';
import 'package:account/models/transaction.dart' as keyId;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  String dbName;

  TransactionDB({required this.dbName});


  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }


  Future<int> insertDatabase(keyId.Transaction storage) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('movies');

    var key = await store.add(db, {
      "title": storage.title,
      "year": storage.year.toString(),
      "genre": storage.genre,
      "watched": storage.watched,
    });

    await db.close();
    return key; 
  }


  Future<List<keyId.Transaction>> loadAllData() async {
  var db = await this.openDatabase();
  var store = intMapStoreFactory.store('movies');
  var snapshot = await store.find(db);

  List<keyId.Transaction> transactions = [];

  for (var record in snapshot) {
    var data = record.value as Map<String, dynamic>;

    transactions.add(keyId.Transaction(
      title: data['title'],
      year: double.parse(data['year']),
      genre: data['genre'],
      watched: data['watched'] ?? false,
      id: record.key, 
    ));
  }

  await db.close();
  return transactions;
}

  Future<void> deleteTransaction(int key) async {
  var db = await this.openDatabase();
  var store = intMapStoreFactory.store('movies');

  await store.record(key).delete(db);
  
  await db.close();
}

  
}
