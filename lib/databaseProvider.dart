import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static final int version = 1;
  static Database _database;
  static final String packstableName = 'packs';
  static final String customerstableName = 'custs';

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    path += 'pubg.db';
    return await openDatabase(
      path,
      version: version,
      onCreate: (db, version) async {
        await db.execute('''
          create table $packstableName (
            invoiceId integer unique primary key autoincrement,
            id integer not null,
            name text not null,
            cost double not null,
            price double not null,
            image text,
            date text,
            customerID integer
          )
          ''');
        await db.execute('''
          create table $customerstableName (
            id integer unique primary key autoincrement,
            name text not null,
            dept double,
            inDept boolean
          )
          ''');
      },
    );
  }

  Future<List<PubgUc>> get packs async {
    final db = await database;
    List<Map> result = await db.query(packstableName);
    List<PubgUc> packs = [];
    for (var value in result) {
      packs.add(PubgUc.fromMap(value));
    }
    return packs;
  }

  Future<List<Customer>> get custs async {
    final db = await database;
    List<Map> result = await db.query(customerstableName);
    List<Customer> custs = [];
    for (var value in result) {
      custs.add(Customer.fromMap(value));
    }
    return custs;
  }

  Future insertInvoice(PubgUc pack) async {
    final db = await database;
    return await db.insert(packstableName, pack.toMap());
  }

  Future insertCustomer(Customer cust) async {
    final db = await database;
    return await db.insert(customerstableName, cust.toMap());
  }
  //add edit customer and edit pack.
}
