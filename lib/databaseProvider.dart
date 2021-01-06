import 'package:plant_app/components/customer.dart';
import 'package:plant_app/components/pubgUC.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  DatabaseProvider._();

  static final DatabaseProvider db = DatabaseProvider._();
  static final int version = 1;
  static Database _database;
  static final String orderstableName = 'orders';
  static final String customerstableName = 'custs';
  static final String packstableName = 'packs';
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
          create table $orderstableName (
            invoiceID integer unique primary key autoincrement,
            id integer not null,
            name text not null,
            cost double not null,
            price double not null,
            image text,
            date text,
            customerName integer,
            count integer,
            profit double,
            isFavorite integer
          )
          ''');
        await db.execute('''
          create table $customerstableName (
            id integer,
            name text unique primary key not null,
            dept double,
            inDept integer default 0,
            date text,
            payment double default 0,
            phone text
          )
          ''');
        await db.execute('''
          create table $packstableName (
            invoiceID integer,
            id integer,
            name text unique primary key not null,
            cost double,
            price double,
            count integer,
            image text,
            date text,
            customerName integer,
            profit double,
            isFavorite integer default '0'
          )
          ''');
        // add image to all items.
        //
        //
        //
        await db.rawInsert('''
        insert into $customerstableName (id,name) values ('0','unknown')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count,image) values ('0','PUBG UC 60','4.2','0','assets/images/Pubg UC 60.png')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('1','PUBG UC 120','7.8','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('2','PUBG UC 180','11.7','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('3','PUBG UC 240','15.6','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('4','PUBG UC 325','17.16','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('5','PUBG UC 445','24.18','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('6','PUBG UC 660','31.2','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('7','PUBG UC 720','34.32','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('8','PUBG UC 770','37.44','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('9','PUBG UC 840','40.56','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('10','PUBG UC 985','46.8','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('11','PUBG UC 1320','62.4','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('12','PUBG UC 1500','71.76','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('13','PUBG UC 1800','78','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('14','PUBG UC 1920','84.24','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('15','PUBG UC 2040','90.48','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('16','PUBG UC 2125','93.6','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('17','PUBG UC 2460','109.2','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('18','PUBG UC 3120','140.4','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('19','PUBG UC 3850','156','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('20','PUBG UC 4030','165.36','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('21','PUBG UC 4235','174.72','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('22','PUBG UC 4510','187.2','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('23','PUBG UC 5650','234','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('24','PUBG UC 6310','265.2','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('25','PUBG UC 8100','315','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('26','PUBG UC 8425','330.75','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('27','PUBG UC 8750','346.5','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('28','PUBG UC 9900','393.75','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('29','PUBG UC 11950','472.5','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('30','PUBG UC 13750','551.25','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('31','PUBG UC 16200','630','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('32','PUBG UC 17500','693','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('33','PUBG UC 20050','787.5','0')
        ''');
        await db.rawInsert('''
        insert into $packstableName (id,name,cost,count) values ('34','PUBG UC 24300','945','0')
        ''');
      },
    );
  }

  Future<List<PubgUc>> get orders async {
    final db = await database;
    List<Map> result = await db.query(orderstableName);
    List<PubgUc> order = [];
    for (var value in result) {
      order.add(PubgUc.fromMap(value));
    }
    return order;
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

  Future<List<PubgUc>> get packs async {
    final db = await database;
    List<Map> result = await db.query(packstableName);
    List<PubgUc> pack = [];
    for (var value in result) {
      pack.add(PubgUc.fromMap(value));
    }
    return pack;
  }

  Future insertInvoice(PubgUc order) async {
    final db = await database;
    return await db.insert(orderstableName, order.toMap());
  }

  Future insertPack(PubgUc pack) async {
    final db = await database;
    return await db.insert(packstableName, pack.toMap());
  }

  Future insertCustomer(Customer cust) async {
    final db = await database;
    return await db.insert(customerstableName, cust.toMap());
  }

  //add edit customer and edit pack.
  Future updatePack(PubgUc pack) async {
    final db = await database;
    return await db.update('$packstableName', pack.toMap(),
        where: 'id=?', whereArgs: [pack.id]);
  }

  Future updateCustomer(Customer customer) async {
    final db = await database;
    return await db.update('$customerstableName', customer.toMap(),
        where: 'name=?', whereArgs: [customer.name]);
  }

  Future<int> removePack(String name) async {
    final db = await database;
    return await db
        .delete('$packstableName', where: 'name=?', whereArgs: [name]);
  }

  Future<int> removeCustomer(String name) async {
    final db = await database;
    return await db
        .delete('$customerstableName', where: 'name=?', whereArgs: [name]);
  }
}
